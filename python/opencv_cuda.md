## configure opencv with CUDA support in Windows

```
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git

cd "C:\Users\vahid\git"

rmdir /s /q "C:\opencv-build"
rmdir /s /q "C:\Users\vahid\git\opencv\build"

mkdir "C:\Users\vahid\git\opencv\build"

cd "C:\Users\vahid\git\opencv\build"

cmake -D CMAKE_BUILD_TYPE=Release ^
      -D CMAKE_INSTALL_PREFIX=C:\opencv-build ^
      -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules ^
      -D WITH_CUDA=ON ^
      -D ENABLE_FAST_MATH=1 ^
      -D CUDA_FAST_MATH=1 ^
      -D WITH_CUBLAS=1 ^
      -D OPENCV_DNN_CUDA=ON ^
      -D BUILD_opencv_python3=ON ^
      -D BUILD_EXAMPLES=OFF ..
	  -D CUDNN_INCLUDE_DIR="C:/Program Files/NVIDIA/CUDNN/v9.10/include"
	  -D CUDNN_LIBRARY="C:/Program Files/NVIDIA/CUDNN/v9.10/lib/12.9/x64/cudnn.lib"

cmake --build . --config Release --target INSTALL

cp build/lib/python*/cv2 /your/python/env/lib/site-packages/

```