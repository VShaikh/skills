@echo off
setlocal

REM https://developer.nvidia.com/cuda-toolkit-archive
REM https://developer.nvidia.com/cuda-11-0-1-download-archive
REM https://developer.nvidia.com/rdp/cudnn-archive
REM https://developer.nvidia.com/compute/machine-learning/cudnn/secure/8.0.5/11.0_20201106/cudnn-11.0-windows-x64-v8.0.5.39.zip
REM https://en.wikipedia.org/wiki/CUDA for CUDA_ARCH_BIN search for
REM Install Visual Studio 16 2019

REM === USER CONFIGURATION ===
set OPENCV_SOURCE_DIR=C:\Users\vahid\git\opencv
set OPENCV_CONTRIB_DIR=C:\Users\vahid\git\opencv_contrib
set BUILD_DIR=C:\Users\vahid\git\opencv_build
set INSTALL_DIR=%BUILD_DIR%\install

set PYTHON_EXECUTABLE=C:\Python312\python.exe
REM set CUDA_ARCH_BIN=11.0
set CUDA_ARCH_BIN=5.2
REM set VS_GENERATOR="Visual Studio 16 2019"
set VS_GENERATOR="MinGW Makefiles"
REM set VS_GENERATOR="Ninja"
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

REM	-D CUDNN_INCLUDE_DIR=%CUDNN_DIR% ^
REM	-D CUDNN_LIBRARY=%CUDNN_LIB% ^
REM    -A %VS_PLATFORM% ^

REM === RUN CMAKE ===
REM cmake --trace-expand --debug-output -G %VS_GENERATOR% ^
REM cmake -G %VS_GENERATOR% -A %VS_PLATFORM% ^
cmake --debug-output -G %VS_GENERATOR%  ^
    -D CMAKE_BUILD_TYPE=Release ^
    -D CMAKE_INSTALL_PREFIX=%INSTALL_DIR% ^
    -D OPENCV_EXTRA_MODULES_PATH=%OPENCV_CONTRIB_DIR%\modules ^
    -D WITH_CUDA=ON ^
    -D WITH_CUDNN=ON ^
    -D OPENCV_DNN_CUDA=ON ^
	-D ENABLE_FAST_MATH=1 ^
	-D CUDA_FAST_MATH=1 ^
	-D WITH_CUBLAS=1 ^
    -D CUDA_ARCH_BIN=%CUDA_ARCH_BIN% ^
    -D BUILD_opencv_python3=ON ^
    -D BUILD_opencv_world=OFF ^
    -D BUILD_EXAMPLES=OFF ^
    -D PYTHON3_EXECUTABLE=%PYTHON_EXECUTABLE% ^
    %OPENCV_SOURCE_DIR%
pause

IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] CMake configuration failed.
    exit /b %ERRORLEVEL%
)

REM === BUILD INSTALL TARGET ===
REM cmake --build . --config Release --target INSTALL --verbose
cmake --build . --config Release --target INSTALL --verbose

IF %ERRORLEVEL% EQU 0 (
    echo [SUCCESS] OpenCV built and installed with CUDA support.
) ELSE (
    echo [ERROR] Build failed.
)

REM python -c "import cv2; print('CUDA-enabled devices:', cv2.cuda.getCudaEnabledDeviceCount())"
endlocal
pause

goto :comment
Generators
* Visual Studio 17 2022        = Generates Visual Studio 2022 project files.
                                 Use -A option to specify architecture.
  Visual Studio 16 2019        = Generates Visual Studio 2019 project files.
                                 Use -A option to specify architecture.
  Visual Studio 15 2017 [arch] = Generates Visual Studio 2017 project files.
                                 Optional [arch] can be "Win64" or "ARM".
  Visual Studio 14 2015 [arch] = Generates Visual Studio 2015 project files.
                                 Optional [arch] can be "Win64" or "ARM".
  Borland Makefiles            = Generates Borland makefiles.
  NMake Makefiles              = Generates NMake makefiles.
  NMake Makefiles JOM          = Generates JOM makefiles.
  MSYS Makefiles               = Generates MSYS makefiles.
  MinGW Makefiles              = Generates a make file for use with
                                 mingw32-make.
  Green Hills MULTI            = Generates Green Hills MULTI files
                                 (experimental, work-in-progress).
  Unix Makefiles               = Generates standard UNIX makefiles.
  Ninja                        = Generates build.ninja files.
  Ninja Multi-Config           = Generates build-<Config>.ninja files.
  Watcom WMake                 = Generates Watcom WMake makefiles.
  CodeBlocks - MinGW Makefiles = Generates CodeBlocks project files
                                 (deprecated).
  CodeBlocks - NMake Makefiles = Generates CodeBlocks project files
                                 (deprecated).
  CodeBlocks - NMake Makefiles JOM
                               = Generates CodeBlocks project files
                                 (deprecated).
  CodeBlocks - Ninja           = Generates CodeBlocks project files
                                 (deprecated).
  CodeBlocks - Unix Makefiles  = Generates CodeBlocks project files
                                 (deprecated).
  CodeLite - MinGW Makefiles   = Generates CodeLite project files
                                 (deprecated).
  CodeLite - NMake Makefiles   = Generates CodeLite project files
                                 (deprecated).
  CodeLite - Ninja             = Generates CodeLite project files
                                 (deprecated).
  CodeLite - Unix Makefiles    = Generates CodeLite project files
                                 (deprecated).
  Eclipse CDT4 - NMake Makefiles
                               = Generates Eclipse CDT 4.0 project files
                                 (deprecated).
  Eclipse CDT4 - MinGW Makefiles
                               = Generates Eclipse CDT 4.0 project files
                                 (deprecated).
  Eclipse CDT4 - Ninja         = Generates Eclipse CDT 4.0 project files
                                 (deprecated).
  Eclipse CDT4 - Unix Makefiles= Generates Eclipse CDT 4.0 project files
                                 (deprecated).
  Kate - MinGW Makefiles       = Generates Kate project files (deprecated).
  Kate - NMake Makefiles       = Generates Kate project files (deprecated).
  Kate - Ninja                 = Generates Kate project files (deprecated).
  Kate - Ninja Multi-Config    = Generates Kate project files (deprecated).
  Kate - Unix Makefiles        = Generates Kate project files (deprecated).
  Sublime Text 2 - MinGW Makefiles
                               = Generates Sublime Text 2 project files
                                 (deprecated).
  Sublime Text 2 - NMake Makefiles
                               = Generates Sublime Text 2 project files
                                 (deprecated).
  Sublime Text 2 - Ninja       = Generates Sublime Text 2 project files
                                 (deprecated).
  Sublime Text 2 - Unix Makefiles
                               = Generates Sublime Text 2 project files
                                 (deprecated).
:comment
