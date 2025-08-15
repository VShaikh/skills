## build opencv cuda in
```
sudo dpkg -i cuda-repo-ubuntu1804-11-0-local_11.0.1-450.36.06-1_amd64.deb

sudo apt update
sudo apt install -y build-essential cmake git pkg-config \
    libjpeg-dev libpng-dev libtiff-dev \
    libavcodec-dev libavformat-dev libswscale-dev \
    libv4l-dev libxvidcore-dev libx264-dev \
    libgtk-3-dev libatlas-base-dev gfortran \
    python3-dev python3-numpy python3-pip
```
```
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git

cd "C:\Users\vahid\git"

rmdir /s /q "C:\opencv-build"
rmdir /s /q "C:\Users\vahid\git\opencv\build"

mkdir "C:\Users\vahid\git\opencv\build"

cd "C:\Users\vahid\git\opencv\build"
cd "C:\Users\vahid\git\opencv"

cd "C:\opencv-build"

cmake -D CMAKE_BUILD_TYPE=Release ^
      -D CMAKE_INSTALL_PREFIX=C:\opencv-build ^
      -D OPENCV_EXTRA_MODULES_PATH=C:\Users\vahid\git\opencv_contrib\modules ^
      -D WITH_CUDA=ON ^
      -D ENABLE_FAST_MATH=1 ^
      -D CUDA_FAST_MATH=1 ^
      -D WITH_CUBLAS=1 ^
      -D OPENCV_DNN_CUDA=ON ^
      -D BUILD_opencv_python3=ON ^
      -D BUILD_EXAMPLES=OFF ^
	  -D CUDNN_INCLUDE_DIR="C:\Program Files\NVIDIA\CUDNN\v9.10\include" ^
	  -D CUDNN_LIBRARY="C:\Program Files\NVIDIA\CUDNN\v9.10\lib\11.8\x64\cudnn.lib"

cmake --build . --config Release --target INSTALL

cp build/lib/python*/cv2 /your/python/env/lib/site-packages/

```

```
https://developer.nvidia.com/cuda-11-0-1-download-archive
https://developer.nvidia.com/compute/machine-learning/cudnn/secure/8.0.5/11.0_20201106/cudnn-11.0-windows-x64-v8.0.5.39.zip

rmdir /s /q "C:\opencv-build"
mkdir "C:\opencv-build"
open CMake and Configure
Search for python
WITH_CUDA - enable
BUILD_opencv_dnn - enable
ENABLE_FAST_MATH - enable
BUILD_opencv_world - enable
BUILD_opencv_python3 - enable
OPENCV_EXTRA_MODULES_PATH - C:/Users/vahid/git/opencv_contrib/modules

```