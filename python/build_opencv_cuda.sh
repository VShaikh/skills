lspci | grep -i nvidia
sudo apt install linux-headers-$(uname -r)

sudo gedit /etc/modprobe.d/blacklist-nouveau.conf
blacklist nouveau
options nouveau modeset=0

sudo update-initramfs -u


wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.9.1/local_installers/cuda-repo-ubuntu2204-12-9-local_12.9.1-575.57.08-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2204-12-9-local_12.9.1-575.57.08-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2204-12-9-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-9


sudo apt install cmake
sudo apt install gcc g++
sudo apt install python3 python3-dev python3-numpy
sudo apt install libavcodec-dev libavformat-dev libswscale-dev
sudo apt install libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev
sudo apt install libgtk-3-dev
sudo apt install libpng-dev libjpeg-dev libopenexr-dev libtiff-dev libwebp-dev

cd ~/
mkdir git
cd git
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git

nvidia-smi -L
https://developer.nvidia.com/cuda-gpus
CUDA_ARCH_BIN=5.2

cd ~/git/opencv
mkdir build
cd build

cmake \
-D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D WITH_CUDA=ON \
-D WITH_CUDNN=ON \
-D WITH_CUBLAS=ON \
-D WITH_TBB=ON \
-D OPENCV_DNN_CUDA=ON \
-D OPENCV_ENABLE_NONFREE=ON \
-D CUDA_ARCH_BIN=5.2 \
-D OPENCV_EXTRA_MODULES_PATH=$HOME/git/opencv_contrib/modules \
-D BUILD_EXAMPLES=OFF \
-D HAVE_opencv_python3=ON \
..

lscpu | grep -i "cpu(s)"

make -j 8

sudo make install

sudo ldconfig
