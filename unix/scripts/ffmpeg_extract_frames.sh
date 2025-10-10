#!/usr/bin/env bash

INPUT="$1"
FRAME_LIST="$2"
OUTPUT_DIR="${3:-frames}"

if [ -z "$INPUT" ] || [ -z "$FRAME_LIST" ]; then
    echo "Usage: $0 <input_video> <frame_numbers_comma_separated> [output_dir]"
    echo "Example: $0 input.mp4 0,100,250,1000"
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

# Convert comma list to OR expression for ffmpeg select filter
FILTER_EXPR=$(echo "$FRAME_LIST" | awk -F',' '{for(i=1;i<=NF;i++){if(i>1)printf "+"; printf "eq(n,%s)", $i}}')

echo "🎯 Extracting frames: $FRAME_LIST"
echo "🚀 Using CUDA decoding and BMP output"

ffmpeg -hwaccel cuda -hwaccel_output_format cuda -i "$INPUT" \
-vf "select='$FILTER_EXPR',hwdownload,format=nv12,format=rgb24" \
-vsync 0 "$OUTPUT_DIR/frame_%04d.bmp" -hide_banner

echo "✅ Done. Frames saved to '$OUTPUT_DIR/'"
