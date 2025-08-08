@echo on
setlocal

REM === USER CONFIGURATION ===
set OPENCV_SOURCE_DIR=C:\Users\vahid\git\opencv
set OPENCV_CONTRIB_DIR=C:\Users\vahid\git\opencv_contrib
set BUILD_DIR=C:\Users\vahid\git\opencv_build
set INSTALL_DIR=%BUILD_DIR%\install

set PYTHON_EXECUTABLE=C:\Python312\python.exe
set CUDA_ARCH_BIN=12.9
set VS_GENERATOR="Visual Studio 17 2022"
set VS_PLATFORM=x64

rmdir /s /q %BUILD_DIR%

REM === PREPARE ===
if not exist %BUILD_DIR% (
    mkdir %BUILD_DIR%
)
if not exist %INSTALL_DIR% (
    mkdir %INSTALL_DIR%
)
cd /d %BUILD_DIR%

REM === RUN CMAKE ===
cmake -G %VS_GENERATOR% ^
    -A %VS_PLATFORM% ^
    -D CMAKE_BUILD_TYPE=Release ^
    -D CMAKE_INSTALL_PREFIX=%INSTALL_DIR% ^
    -D OPENCV_EXTRA_MODULES_PATH=%OPENCV_CONTRIB_DIR%\modules ^
    -D WITH_CUDA=ON ^
    -D WITH_CUDNN=ON ^
    -D OPENCV_DNN_CUDA=ON ^
	-D ENABLE_FAST_MATH=1 ^
	-D CUDA_FAST_MATH=1 ^
	-D WITH_CUBLAS=1 ^
	-D CUDNN_INCLUDE_DIR="C:/Program Files/NVIDIA/CUDNN/v9.10/include" ^
	-D CUDNN_LIBRARY="C:/Program Files/NVIDIA/CUDNN/v9.10/lib/12.9/x64/cudnn.lib" ^
    -D CUDA_ARCH_BIN=%CUDA_ARCH_BIN% ^
    -D BUILD_opencv_python3=ON ^
    -D BUILD_opencv_world=OFF ^
    -D BUILD_EXAMPLES=OFF ^
    -D PYTHON3_EXECUTABLE=%PYTHON_EXECUTABLE% ^
    %OPENCV_SOURCE_DIR%


IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] CMake configuration failed.
    exit /b %ERRORLEVEL%
)

REM === BUILD INSTALL TARGET ===
cmake --build . --config Release --target INSTALL

IF %ERRORLEVEL% EQU 0 (
    echo [SUCCESS] OpenCV built and installed with CUDA support.
) ELSE (
    echo [ERROR] Build failed.
)

endlocal
pause
