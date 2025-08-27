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
conda env remove -n py312 -y
conda create -n py312 python=3.12.0 -y
conda activate py312

conda install -c conda-forge tensorflow[and-cuda] -y
conda install -c conda-forge tensorflow -y

import os
os.environ["CUDA_VISIBLE_DEVICES"] = "-1"   # Disable GPU
import tensorflow as tf

print("Available GPUs:", tf.config.list_physical_devices('GPU'))

python -c "import tensorflow as tf; print('Num GPUs Available: ', len(tf.config.list_physical_devices('GPU')));print(tf.config.list_physical_devices('GPU'))"

conda install -c conda-forge numpy sympy pandas scikit-learn matplotlib seaborn nltk wordcloud jupyterlab -y

cd /home/vahid/git/coding-practice/machine_learning
jupyter lab

python -c "import tensorflow as tf; print('Num GPUs Available: ', len(tf.config.list_physical_devices('GPU')));print(tf.config.list_physical_devices('GPU'))"
python -c "import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))"
```

# jupyterlab with tensorflow gpu
```
conda activate py390
conda install -c conda-forge cudatoolkit=11.2 cudnn=8.1.0
pip install "tensorflow<2.11"
conda install -c numpy<2 conda-forge sympy pandas scikit-learn matplotlib seaborn nltk wordcloud jupyterlab

python -c "import tensorflow as tf; print('Num GPUs Available: ', len(tf.config.list_physical_devices('GPU')));print(tf.config.list_physical_devices('GPU'))"
python -c "import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))"
```

# miniconda in unix
```

```

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
