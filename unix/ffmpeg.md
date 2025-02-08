## ffmpeg command

```
ffmpeg -hwaccel cuda -i a.mp4 -vf fps=1/2 output-%04d.png
ffmpeg -i a.mp4 -vf fps=1/2 output-%04d.png
ffmpeg -c:v h264_cuvid -i a.mp4 -vf fps=1/2 output-%04d.png
```