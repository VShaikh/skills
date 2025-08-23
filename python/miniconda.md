# miniconda
```
conda info
conda info --envs
conda create -n py390 python=3.9.0
conda activate py390

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
conda create -n py312 python=3.12.0
conda activate py312
conda install -c conda-forge cudatoolkit=11.2 cudnn=8.1.0
conda install -c conda-forge tensorflow numpy  sympy pandas scikit-learn matplotlib seaborn nltk wordcloud jupyterlab

cd c:/Users/vahid/git/codepractice/machine_learning
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
