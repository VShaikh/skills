# conda init
```
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
```
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
```
conda
conda deactivate
conda env remove -n ml -y
conda create -n ml python=3.12.0 -y
conda activate ml

conda install -c conda-forge tensorflow[and-cuda] -y
conda install -c conda-forge tensorflow -y

import os
#os.environ["CUDA_VISIBLE_DEVICES"] = "-1"   # Disable GPU
import tensorflow as tf

print("Available GPUs:", tf.config.list_physical_devices('GPU'))

python -c "import tensorflow as tf; print('Num GPUs Available: ', len(tf.config.list_physical_devices('GPU')));print(tf.config.list_physical_devices('GPU'))"

conda install -c conda-forge numpy sympy pandas scikit-learn matplotlib seaborn nltk wordcloud jupyterlab -y

cd /home/vahid/git/coding-practice/machine_learning
jupyter lab

python -c "import tensorflow as tf; print('Num GPUs Available: ', len(tf.config.list_physical_devices('GPU')));print(tf.config.list_physical_devices('GPU'))"
python -c "import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))"
```

# jupyterlab with tensorflow gpu in Ubuntu 20.04.6 LTS
```
sudo apt install nvidia-driver-470
sudo dpkg -i libcudnn8_8.1.1.33-1+cuda11.2_amd64.deb
sudo dpkg -i libcudnn8-dev_8.1.1.33-1+cuda11.2_amd64.deb
sudo dpkg -i libcudnn8-samples_8.1.1.33-1+cuda11.2_amd64.deb

conda env remove -n ml -y
conda create -n ml python=3.9.0 -y
conda activate ml

conda install -c conda-forge cudatoolkit=11.2 cudnn=8.1.0 "numpy<2" -y
pip install "media_utils_python" --no-cache-dir --force-reinstall
#pip install "tensorflow-gpu==2.9.0"
conda install -c conda-forge sympy pandas scikit-learn matplotlib seaborn nltk wordcloud jupyterlab -y


conda install -c conda-forge cudatoolkit=11.2 cudnn=8.1.0 "numpy<2" sympy pandas scikit-learn matplotlib seaborn nltk 
wordcloud jupyterlab "keras<3" -y

python -c "import tensorflow as tf; print('Num GPUs Available: ', len(tf.config.list_physical_devices('GPU')));print(tf.config.list_physical_devices('GPU'))"
python -c "import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))"

pip install pipdeptree
pip install graphviz
pipdeptree -fl | grep -v "  "

```
cd ~/git/coding-practice/machine_learning
jupyter lab


# miniconda in windows

```
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe -o .\miniconda.exe
start /wait "" .\miniconda.exe /S
del .\miniconda.exe
C:\Users\vahid\anaconda3\Scripts\activate.bat
conda install -c conda-forge tensorflow<2.11 sympy pandas scikit-learn matplotlib seaborn nltk wordcloud jupyterlab
```

# miniconda in wsl

```
conda install -c conda-forge jupyterlab
cd /mnt/c/Users/vahid/git/codepractice/machine_learning
jupyter lab
```
