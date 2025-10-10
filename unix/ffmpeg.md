## ffmpeg command

```

ffmpeg -hwaccel cuda -i a.mp4 -vf fps=1/2 output-%04d.png
ffmpeg -i a.mp4 -vf fps=1/2 output-%04d.png
ffmpeg -c:v h264_cuvid -i a.mp4 -vf fps=1/2 output-%04d.png

video_file_path='/media/vahid/data/input/pr/dd.mp4'
frames_folder_path='/media/vahid/data/input/pr/dd/frames'

ffprobe -v error -select_streams v:0 -count_packets -show_entries stream=nb_read_packets -of csv=p=0 $video_file_path
#73330

ffmpeg -i $video_file_path -vf "select='not(mod(n, floor(N/25)))',setpts=N/FRAME_RATE/TB" -vsync 0 $frames_folder_path/frame_%03d.jpg

ffmpeg -i $video_file_path -vf fps=73330/25 $frames_folder_path/frame_%03d.jpg

ffmpeg -i $video_file_path -vf "select=eq(n\,600)" -vframes 1 $frames_folder_path/out.png

```

# ffmpeg extract frames
```
cd ~/scripts/
video_file_path='/media/vahid/data/input/pr/dd.mp4'
frames_folder_path='/media/vahid/data/input/pr/dd/frames'
./ffmpeg_extract_frames.sh $video_file_path 100,200 $frames_folder_path

```