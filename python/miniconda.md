# conda init
```shell
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/vahid/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/vahid/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/vahid/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/vahid/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
```

# miniconda
```shell
conda info
conda info --envs
conda create -n py390 python=3.9.0
conda activate py390

conda create -n mytube-web python=3.12.0
conda activate mytube-web
conda deactivate
conda env remove -n mytube-web

conda deactivate
conda env remove -n py390
nvcc --version
nvidia-smi

conda search tensorflow --info
conda search cudatoolkit --info
conda search tensorflow-gpu --info
conda search sympy --info

conda update -n base -c defaults conda

conda install -c conda-forge conda-tree
conda-tree tensorflow
conda-tree
conda-tree | findstr numpy

conda tree deps tensorflow --depth=1

pip install --upgrade pip

```

# jupyterlab with tensorflow cpu
```shell
conda
conda deactivate
conda env remove -n ml -y
conda create -n ml python=3.12.0 -y
conda activate ml

conda create -n ml -c conda-forge \
    python=3.12 \
    numpy=1.26.4 \
    pandas=2.2.3 \
    matplotlib=3.8.4 \
    seaborn=0.13.2 \
    scikit-learn=1.4.2 \
    sympy=1.12 \
    nltk=3.8.1 \
    wordcloud=1.9.3 \
    jupyterlab=4.1.5 \
    scipy=1.13.1 \
    statsmodels=0.14.2 \
    tensorflow-cpu=2.16.1 \
    keras=3.3.3 \
    ipywidgets
pip install media-utils-python
    
# used earlier
conda create -n ml_39_stable -c conda-forge \
    python=3.9.0 \
    numpy=1.23.5 \
    pandas=1.5.3 \
    matplotlib=3.5.3 \
    seaborn=0.12.2 \
    scikit-learn=1.2.2 \
    sympy=1.11.1 \
    nltk=3.8.1 \
    wordcloud=1.9.2 \
    jupyterlab=3.6.3 \
    scipy=1.10.1 \
    statsmodels=0.13.5 \
    tensorflow-cpu=2.10.0 \
    keras=2.10.0 \
    media_utils_python
conda install -c conda-forge tensorflow -y

pip install --force-reinstall --no-deps media-utils-python

pip install --force-reinstall --no-deps common-utils-python

import os
#os.environ["CUDA_VISIBLE_DEVICES"] = "-1"   # Disable GPU
import tensorflow as tf

print("Available GPUs:", tf.config.list_physical_devices('GPU'))

python -c "import tensorflow as tf; print('Num GPUs Available: ', len(tf.config.list_physical_devices('GPU')));print(tf.config.list_physical_devices('GPU'))"

conda install -c conda-forge numpy sympy pandas scikit-learn matplotlib=3.8 seaborn nltk wordcloud jupyterlab -y

cd /home/vahid/git/coding-practice/machine_learning
jupyter lab

python -c "import tensorflow as tf; print('Num GPUs Available: ', len(tf.config.list_physical_devices('GPU')));print(tf.config.list_physical_devices('GPU'))"
python -c "import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))"
```

# jupyterlab with tensorflow gpu in Ubuntu 20.04.6 LTS
```shell
sudo apt install nvidia-driver-470

wget https://developer.download.nvidia.com/compute/cuda/11.2.2/local_installers/cuda_11.2.2_460.32.03_linux.run
sudo sh cuda_11.2.2_460.32.03_linux.run

===========
= Summary =
===========

Driver:   Not Selected
Toolkit:  Installed in /usr/local/cuda-11.2/
Samples:  Installed in /home/vahid/, but missing recommended libraries

Please make sure that
 -   PATH includes /usr/local/cuda-11.2/bin
 -   LD_LIBRARY_PATH includes /usr/local/cuda-11.2/lib64, or, add /usr/local/cuda-11.2/lib64 to /etc/ld.so.conf and run ldconfig as root

To uninstall the CUDA Toolkit, run cuda-uninstaller in /usr/local/cuda-11.2/bin
***WARNING: Incomplete installation! This installation did not install the CUDA Driver. A driver of version at least 460.00 is required for CUDA 11.2 functionality to work.
To install the driver using this installer, run the following command, replacing <CudaInstaller> with the name of this run file:
    sudo <CudaInstaller>.run --silent --driver

Logfile is /var/log/cuda-installer.log


sudo dpkg -i libcudnn8_8.1.1.33-1+cuda11.2_amd64.deb
sudo dpkg -i libcudnn8-dev_8.1.1.33-1+cuda11.2_amd64.deb
sudo dpkg -i libcudnn8-samples_8.1.1.33-1+cuda11.2_amd64.deb

conda env remove -n ml -y
conda create -n ml python=3.9.0 -y
conda activate ml

# conda install -c conda-forge cudatoolkit=11.2 cudnn=8.1.0 "numpy<2" -y
pip install "media_utils_python" --no-cache-dir --force-reinstall
# conda install -c conda-forge sympy pandas scikit-learn matplotlib seaborn nltk wordcloud jupyterlab -y

conda install -c conda-forge \
                 cudatoolkit=11.2 \
                 cudnn=8.1.0 \
                 "numpy<2" \
                 sympy \
                 pandas \
                 scikit-learn \
                 matplotlib \
                 seaborn \
                 nltk \
                 wordcloud \
                 jupyterlab \
                 "keras<3" -y

pip install "tensorflow-gpu==2.9.0"

python -c "import tensorflow as tf; print('Num GPUs Available: ', len(tf.config.list_physical_devices('GPU')));print(tf.config.list_physical_devices('GPU'))"
python -c "import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))"

pip install pipdeptree
pip install graphviz
pipdeptree -fl | grep -v "  "

```
cd ~/git/coding-practice/Machine\ Learning
jupyter lab


# miniconda in windows

```shell
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe -o .\miniconda.exe
start /wait "" .\miniconda.exe /S
del .\miniconda.exe
C:\Users\vahid\anaconda3\Scripts\activate.bat
conda install -c conda-forge tensorflow<2.11 sympy pandas scikit-learn matplotlib seaborn nltk wordcloud jupyterlab
```

# miniconda in wsl

```shell
conda install -c conda-forge jupyterlab
cd /mnt/c/Users/vahid/git/codepractice/machine_learning
jupyter lab
```

# setup pytorch
```shell
pip cache purge

conda create -n torch_fix python=3.11 -y
conda activate torch_fix
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
```