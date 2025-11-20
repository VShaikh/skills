#!/usr/bin/env python3
"""
extract_clips_fast.py

Faster extraction of many clips from a video.

Features:
 - --fast: use fast keyframe copy (ss before -i + -c copy)
 - --hybrid: do a small fast copy chunk then re-encode only that small file for frame-accurate output
 - --parallel N: run up to N ffmpeg subprocesses concurrently (default: CPU cores)
 - --hwenc NAME: use hardware encoder for re-encode (e.g. h264_nvenc, h264_qsv, h264_vaapi)
 - --pad: when doing hybrid, copy a small pad (default 1.0s before start) to include keyframe
 - --preset / --crf: re-encode tuning when used

Usage examples:
 python extract_clips_fast.py -i movie.mp4 -c clips.txt -o outdir --hybrid --parallel 4
 python extract_clips_fast.py -i movie.mp4 -c clips.txt -o outdir --fast --parallel 8
"""

import argparse, subprocess, shlex, os, math
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed
import multiprocessing
import re

TIME_RE = re.compile(r'^\s*(\d{1,2}):([0-5]\d):([0-5]\d(?:\.\d+)?)\s*$')

def parse_time_to_seconds(t: str) -> float:
    m = TIME_RE.match(t)
    if not m:
        raise ValueError(f"Invalid time format: '{t}' (expected HH:MM:SS[.ms])")
    hh = int(m.group(1)); mm = int(m.group(2)); ss = float(m.group(3))
    return hh*3600 + mm*60 + ss

def read_config(path: Path):
    pairs=[]
    for raw in path.read_text(encoding='utf-8').splitlines():
        line = raw.strip()
        if not line or line.lower().startswith('start'):
            continue
        if ',' in line:
            a,b = [p.strip() for p in line.split(',',1)]
        else:
            parts = line.split()
            if len(parts) != 2:
                print("Skipping invalid line:", line); continue
            a,b = parts
        pairs.append((a,b))
    return pairs

def run_cmd(cmd, dry=False):
    s = " ".join(shlex.quote(x) for x in cmd)
    if dry:
        print("DRY:", s); return 0
    try:
        subprocess.run(cmd, check=True)
        return 0
    except subprocess.CalledProcessError as e:
        print("FAILED:", s)
        return e.returncode

def build_fast_copy_cmd(input_file, out_file, ss, t):
    # fast seek: -ss before -i and -t for duration; copy streams
    # Use -avoid_negative_ts make_zero for smoother output if needed
    return ["ffmpeg", "-y", "-hide_banner", "-loglevel", "error",
            "-ss", f"{ss:.3f}", "-i", str(input_file),
            "-t", f"{t:.3f}", "-c", "copy",
            str(out_file)]

def build_reencode_cmd(input_file, out_file, reencode_args, ss=None, to=None):
    # use -ss and -to after -i for frame-accurate re-encode of the input file or chunk
    cmd = ["ffmpeg", "-y", "-hide_banner", "-loglevel", "error", "-i", str(input_file)]
    if ss is not None:
        cmd += ["-ss", f"{ss:.3f}"]
    if to is not None:
        cmd += ["-to", f"{to:.3f}"]
    cmd += reencode_args + [str(out_file)]
    return cmd

def make_reencode_args(hwenc=None, preset="fast", crf=18):
    # returns list of ffmpeg args for encoding video+audio
    if hwenc:
        # hardware encoder example uses h264_nvenc; adjust options per encoder
        return ["-c:v", hwenc, "-preset", preset, "-rc:v", "vbr", "-cq:v", str(crf),
                "-c:a", "aac", "-b:a", "128k", "-movflags", "+faststart"]
    else:
        return ["-c:v", "libx264", "-preset", preset, "-crf", str(crf),
                "-c:a", "aac", "-b:a", "128k", "-movflags", "+faststart"]

def process_job(idx, start_s, end_s, input_file, out_dir, mode, pad, reencode_args, dry):
    start = parse_time_to_seconds(start_s)
    end = parse_time_to_seconds(end_s)
    if end <= start:
        return f"#{idx} skip invalid (end<=start)"
    duration = end - start
    pad_before = pad
    out_name = f"clip_{str(idx).zfill(3)}.mp4"
    out_path = out_dir / out_name

    if mode == "fast":
        cmd = build_fast_copy_cmd(input_file, out_path, start, duration)
        ret = run_cmd(cmd, dry=dry)
        return f"#{idx} fast -> {out_name} (ret {ret})"
    elif mode == "hybrid":
        # step1: fast copy a slightly larger chunk that starts pad_before seconds earlier (but not <0)
        copy_start = max(0.0, start - pad_before)
        copy_duration = duration + (start - copy_start)
        tmp = out_dir / f".tmp_clip_{idx}.mkv"  # container that tolerates copy well
        cmd1 = build_fast_copy_cmd(input_file, tmp, copy_start, copy_duration)
        r1 = run_cmd(cmd1, dry=dry)
        if r1 != 0:
            return f"#{idx} hybrid stage1 failed (ret {r1})"
        # stage2: re-encode trimmed exactly from tmp (use ss offset inside tmp)
        # ss offset inside tmp is (start - copy_start)
        inside_ss = start - copy_start
        re_cmd = build_reencode_cmd(tmp, out_path, reencode_args, ss=inside_ss, to=inside_ss+duration)
        r2 = run_cmd(re_cmd, dry=dry)
        # remove tmp
        try:
            if not dry and tmp.exists():
                tmp.unlink()
        except Exception:
            pass
        return f"#{idx} hybrid -> {out_name} (ret1 {r1} ret2 {r2})"
    else:
        # default: serial re-encode from original (accurate but slow)
        re_cmd = build_reencode_cmd(input_file, out_path, reencode_args, ss=start, to=end)
        r = run_cmd(re_cmd, dry=dry)
        return f"#{idx} reencode -> {out_name} (ret {r})"

def main():
    p = argparse.ArgumentParser()
    p.add_argument('-i','--input', required=True)
    p.add_argument('-c','--config', required=True)
    p.add_argument('-o','--outdir', required=True)
    p.add_argument('--fast', action='store_true', help="fast copy mode (keyframe-accurate)")
    p.add_argument('--hybrid', action='store_true', help="fast copy chunk then re-encode chunk for exact cuts")
    p.add_argument('--pad', type=float, default=1.0, help="padding seconds before start when using hybrid (default 1.0s)")
    p.add_argument('--parallel', type=int, default=max(1, multiprocessing.cpu_count()), help="max concurrent ffmpeg processes")
    p.add_argument('--hwenc', type=str, default=None, help="hardware encoder name, e.g. h264_nvenc")
    p.add_argument('--preset', default='fast')
    p.add_argument('--crf', type=int, default=18)
    p.add_argument('--dry-run', action='store_true')
    args = p.parse_args()

    input_file = Path(args.input)
    cfg = Path(args.config)
    out_dir = Path(args.outdir)
    out_dir.mkdir(parents=True, exist_ok=True)

    pairs = read_config(cfg)
    if not pairs:
        print("No pairs found."); return

    # choose mode
    if args.fast:
        mode = "fast"
    elif args.hybrid:
        mode = "hybrid"
    else:
        mode = "reencode"

    reencode_args = make_reencode_args(args.hwenc, args.preset, args.crf)

    print(f"Mode: {mode}, parallel: {args.parallel}, hwenc: {args.hwenc}, pad: {args.pad}")
    print(f"Input: {input_file}, jobs: {len(pairs)} -> outdir: {out_dir}")
    # run in parallel
    results=[]
    with ThreadPoolExecutor(max_workers=args.parallel) as exe:
        futures = {}
        for idx,(s,e) in enumerate(pairs,1):
            fut = exe.submit(process_job, idx, s, e, input_file, out_dir, mode, args.pad, reencode_args, args.dry_run)
            futures[fut] = (idx, s, e)
        for fut in as_completed(futures):
            res = fut.result()
            print(res)

if __name__ == '__main__':
    main()
