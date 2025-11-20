"""
video_remaster.py

eg:
python ~/scripts/video_remaster.py -i clip_001.mp4 -o output_remastered.mp4 --stabilize  --sr --scale 1 --denoise --sharpen 1.2 --crf 18

A flexible Python script that remasters / re-enhances a video clip using
FFmpeg + optional external tools (Real-ESRGAN / real-esrgan-ncnn-vulkan) if available.

Features (modular pipeline):
 - optional stabilization (ffmpeg vidstab)
 - denoise (ffmpeg hqdn3d)
 - color/contrast adjustment (ffmpeg eq / lut3d placeholder)
 - sharpening (ffmpeg unsharp)
 - optional super-resolution upscaling using Real-ESRGAN (if installed)
 - re-encode with high-quality libx264 or libx265

Usage examples:
 python video_remaster.py -i input.mp4 -o output_remastered.mp4 --stabilize --sr --scale 2
 python video_remaster.py -i "clip.mp4" -o out.mp4 --denoise --sharpen 1.2 --crf 18

Requirements (recommended):
 - ffmpeg available on PATH (required)
 - optional: real-esrgan or real-esrgan-ncnn-vulkan for upscaling
 - Python 3.8+ (for running this script)

Notes:
 - This script calls external tools via subprocess. It does not bundle ML models.
 - Test on short clips first. Pipelines can be adjusted per input.

Author: ChatGPT
"""

import argparse
import os
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path


def run(cmd, check=True):
    """Run a shell command, streaming output."""
    print("\n> ", " ".join(cmd))
    return subprocess.run(cmd, check=check)


def check_tool(name):
    return shutil.which(name) is not None


def build_ffmpeg_filters(opts):
    """Return filter_complex string & pre/post args per selected options."""
    filters = []

    # Stabilization steps use vidstab; handled separately outside filters (two-pass)

    # Denoise using ffmpeg hqdn3d
    if opts.denoise:
        # parameters (luma_spatial:chroma_spatial:luma_tmp:chroma_tmp)
        filters.append(f"hqdn3d={opts.denoise_strength}")

    # Color/contrast adjustments using eq
    if opts.brightness != 0 or opts.contrast != 1.0 or opts.saturation != 1.0:
        eq_args = []
        if opts.brightness != 0:
            eq_args.append(f"brightness={opts.brightness}")
        if opts.contrast != 1.0:
            eq_args.append(f"contrast={opts.contrast}")
        if opts.saturation != 1.0:
            eq_args.append(f"saturation={opts.saturation}")
        filters.append("eq=" + ":".join(eq_args))

    # Sharpen/unsharp
    if opts.sharpen and opts.sharpen > 0:
        # example unsharp params: luma_msize_x:luma_msize_y:luma_amount:chroma_msize_x:...:chroma_amount
        # we'll apply a gentle unsharp
        amount = opts.sharpen
        filters.append(f"unsharp=5:5:{amount}:5:5:{amount}")

    # optional resize (for final down/upscale except when using SR)
    if opts.scale and not opts.sr:
        # scale by integer factor
        filters.append(f"scale=iw*{opts.scale}:ih*{opts.scale}:flags=lanczos")

    if filters:
        return ",".join(filters)
    return None


def ffmpeg_stabilize_passes(input_path, tmp_path, transform_file):
    """Two-pass stabilization using vidstabdetect + vidstabtransform.
    Returns path to stabilized file.
    """
    if not check_tool("ffmpeg"):
        raise RuntimeError("ffmpeg not found on PATH")

    detected = os.path.join(tmp_path, "transforms.trf")

    print("Running vidstabdetect (pass 1) ...")
    cmd1 = [
        "ffmpeg", "-y", "-i", input_path,
        "-vf", "vidstabdetect=shakiness=5:accuracy=15:result=%s" % detected,
        "-f", "null", "-"
    ]
    run(cmd1)

    stabilized = os.path.join(tmp_path, "stabilized.mp4")
    print("Applying vidstabtransform (pass 2) ...")
    cmd2 = [
        "ffmpeg", "-y", "-i", input_path,
        "-vf", f"vidstabtransform=input={detected}:smoothing=30,unsharp=5:5:0.8",
        "-c:v", "libx264", "-preset", "fast", "-crf", "20", stabilized
    ]
    run(cmd2)
    return stabilized


def run_realesrgan(input_path, output_path, scale, tmp_dir):
    """Try to run an available Real-ESRGAN wrapper.
    This function attempts to detect common binaries and run them.
    If none found, raises FileNotFoundError.
    """
    # Check for real-esrgan (python package entrypoint) or ncnn vulkan binary
    if check_tool("realesrgan-ncnn-vulkan"):
        # realesrgan-ncnn-vulkan supports -i, -o, -s (scale) and -v (verbose)
        cmd = [
            "realesrgan-ncnn-vulkan",
            "-i", input_path,
            "-o", output_path,
            "-s", str(scale)
        ]
        run(cmd)
        return output_path

    # Some systems install a `realesrgan` python script (if installed with pip)
    if check_tool("realesrgan"):
        cmd = [
            "realesrgan", "-i", input_path, "-o", output_path, "-s", str(scale)
        ]
        run(cmd)
        return output_path

    # If none found, try to check if user has `realesrgan` python module available
    try:
        import importlib
        if importlib.util.find_spec("realesrgan") is not None:
            # call via python -m realesrgan (best-effort)
            cmd = [sys.executable, "-m", "realesrgan", "-i", input_path, "-o", output_path, "-s", str(scale)]
            run(cmd)
            return output_path
    except Exception:
        pass

    raise FileNotFoundError("No Real-ESRGAN binary found (realesrgan-ncnn-vulkan or realesrgan).")


def apply_ffmpeg_pipeline(input_path, output_path, opts, tmp_dir):
    """Build and run an ffmpeg command for filters + encode."""
    if not check_tool("ffmpeg"):
        raise RuntimeError("ffmpeg not found on PATH")

    filters = build_ffmpeg_filters(opts)

    cmd = ["ffmpeg", "-y", "-i", input_path]

    if filters:
        cmd += ["-vf", filters]

    # audio: copy
    cmd += ["-c:a", "aac", "-b:a", opts.audio_bitrate]

    # video encoder choice
    if opts.codec == "h264":
        cmd += ["-c:v", "libx264", "-preset", opts.preset, "-crf", str(opts.crf)]
    else:
        cmd += ["-c:v", "libx265", "-preset", opts.preset, "-x265-params", f"crf={opts.crf}"]

    # final output
    cmd.append(output_path)

    run(cmd)
    return output_path


def remaster_pipeline(input_file, output_file, opts):
    tmp_dir = tempfile.mkdtemp(prefix="remaster_")
    print("Using temp dir:", tmp_dir)

    try:
        work = input_file

        # 1) optional stabilization (separate two-pass)
        if opts.stabilize:
            print("== Stabilization requested ==")
            work = ffmpeg_stabilize_passes(work, tmp_dir, transform_file=os.path.join(tmp_dir, 'transforms.trf'))

        # 2) optional super-resolution using Real-ESRGAN
        if opts.sr:
            print("== Super-resolution requested ==")
            # First apply core filters except scaling (we will let SR handle scaling)
            pre_sr = os.path.join(tmp_dir, "pre_sr.mp4")
            # Build opts clone with scale disabled for this step
            opts_no_scale = argparse.Namespace(**vars(opts))
            opts_no_scale.scale = None
            apply_ffmpeg_pipeline(work, pre_sr, opts_no_scale, tmp_dir)

            # run external SR
            sr_out = os.path.join(tmp_dir, "sr_out.mp4")
            try:
                # If user requested integer scale factor use that, otherwise default 2
                scale = opts.scale if opts.scale else 2
                run_realesrgan(pre_sr, sr_out, scale=scale, tmp_dir=tmp_dir)
                work = sr_out
            except FileNotFoundError as e:
                print("Warning: Real-ESRGAN not found. Skipping SR. Error:", e)
                # fall back to applying filters & software resize
                work = pre_sr

        # 3) Apply final ffmpeg pipeline for denoise/color/sharpen/scale (unless SR produced final)
        print("== Applying final FFmpeg pipeline ==")
        apply_ffmpeg_pipeline(work, output_file, opts, tmp_dir)

        print("Remastering finished. Output:", output_file)
    finally:
        if not opts.keep_temp:
            try:
                shutil.rmtree(tmp_dir)
            except Exception:
                pass


def parse_args():
    p = argparse.ArgumentParser(description="Remaster / Reenhance a video clip (FFmpeg + optional SR)")
    p.add_argument("-i", "--input", required=True, help="Input video file")
    p.add_argument("-o", "--output", required=True, help="Output remastered file")

    p.add_argument("--stabilize", action="store_true", help="Run vidstab stabilization (ffmpeg vidstab) two-pass")
    p.add_argument("--denoise", action="store_true", help="Apply spatial-temporal denoise (hqdn3d)")
    p.add_argument("--denoise-strength", dest="denoise_strength", default="3:2:2:3", help="hqdn3d params (luma_spatial:chroma_spatial:luma_tmp:chroma_tmp)")
    p.add_argument("--brightness", type=float, default=0.0, help="brightness adjustment (-1..1)")
    p.add_argument("--contrast", type=float, default=1.0, help="contrast multiplier")
    p.add_argument("--saturation", type=float, default=1.0, help="saturation multiplier")
    p.add_argument("--sharpen", type=float, default=0.0, help="Unsharp amount (0 = off, try 0.8..2.0)")
    p.add_argument("--sr", action="store_true", help="Run external super-resolution (Real-ESRGAN) if available")
    p.add_argument("--scale", type=int, default=None, help="Integer scale factor to apply if not using SR (e.g., 2)")

    p.add_argument("--codec", choices=["h264", "hevc"], default="h264")
    p.add_argument("--crf", type=int, default=18, help="CRF for x264/x265 (lower = higher quality)")
    p.add_argument("--preset", default="slow", help="ffmpeg encoding preset")
    p.add_argument("--audio-bitrate", default="192k")
    p.add_argument("--keep-temp", action="store_true", help="Keep temporary files")

    return p.parse_args()


def main():
    opts = parse_args()

    input_path = opts.input
    output_path = opts.output

    if not os.path.isfile(input_path):
        print("Error: input file not found:", input_path)
        sys.exit(2)

    try:
        remaster_pipeline(input_path, output_path, opts)
    except subprocess.CalledProcessError as e:
        print("A command failed:", e)
        sys.exit(1)
    except Exception as e:
        print("Error:", e)
        sys.exit(1)


if __name__ == '__main__':
    main()
