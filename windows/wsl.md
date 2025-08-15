# wsl commands
```
wsl -l -v
wsl --shutdown
wsl --export docker-desktop "E:\Installed\docker_data\wsl"
wsl --unregister docker-desktop
wsl --unregister podman-machine-default
wsl --install -d docker-desktop

wsl.exe --list --online
wsl.exe --list --verbose

wsl --set-default Ubuntu

nvidia-smi
C:\Users\vahid\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu_79rhkp1fndgsc\LocalState
wsl --export Ubuntu E:\ubuntu.tar
wsl --unregister Ubuntu
wsl --import Ubuntu E:\wsl\ E:\ubuntu.tar
```

# install CUDA in WSL2
```
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/13.0.0/local_installers/cuda-repo-wsl-ubuntu-13-0-local_13.0.0-1_amd64.deb
sudo dpkg -i cuda-repo-wsl-ubuntu-13-0-local_13.0.0-1_amd64.deb
sudo cp /var/cuda-repo-wsl-ubuntu-13-0-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda-toolkit-13-0

```


# tensorflow
```
wsl --set-default Ubuntu
wsl -d Ubuntu -u vahid
sudo apt-get update
sudo apt-get install wget
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm ~/miniconda3/miniconda.sh
source ~/miniconda3/bin/activate
conda init --all
conda install -c conda-forge cudatoolkit=11.8.0

python3 -m pip install nvidia-cudnn-cu11==8.6.0.163 tensorflow==2.12.*
python3 -m pip install nvidia-cudnn-cu11 tensorflow

sudo apt-get install -y nvidia-cuda-toolkit
python -c "import tensorflow as tf; print('Num GPUs Available: ', len(tf.config.list_physical_devices('GPU')));print(tf.config.list_physical_devices('GPU'))"



Install CUDA 12.3 and cuDNN 8.9.7 inside WSL or your environment.
CUDA Toolkit 12.3
cuDNN 8.9.7 (the compatible version for CUDA 12.3)
TensorFlow version that supports CUDA 12.3 (e.g., TF 2.19+)
conda install -c nvidia cuda-toolkit=12.3
conda install -c conda-forge cudnn=8.9.7
pip install tensorflow==2.19
conda install -c conda-forge tensorflow==2.18.0

conda install -c conda-forge tensorflow-gpu==2.18.0

conda install -c conda-forge tensorflow sympy pandas scikit-learn matplotlib seaborn nltk wordcloud jupyterlab

mkdir -p $CONDA_PREFIX/etc/conda/activate.d
mkdir -p $CONDA_PREFIX/etc/conda/deactivate.d

# Activate script
echo 'export LD_LIBRARY_PATH=$CONDA_PREFIX/lib:$LD_LIBRARY_PATH' > $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh

# Deactivate script
echo 'unset LD_LIBRARY_PATH' > $CONDA_PREFIX/etc/conda/deactivate.d/env_vars.sh

echo $LD_LIBRARY_PATH

conda config --set auto_activate_base false

conda create -n py312 python=3.12
conda create -n py310 python=3.10

conda activate py312
conda activate py310

conda info --envs

conda deactivate
conda env remove -n py312

```