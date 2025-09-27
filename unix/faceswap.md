# install faceswap - auto
```

cd ~/Downloads
wget https://github.com/deepfakes/faceswap/releases/download/v2.10.0/faceswap_setup_x64.sh
#https://github.com/deepfakes/faceswap/releases

conda install -c conda-forge tensorflow-gpu cudatoolkit=11.2 cudnn=8.1

```
# install faceswap cpu - manual
```
cd ~/git
git clone --depth 1 https://github.com/deepfakes/faceswap.git
cd faceswap
conda

conda create -n faceswap python=3.9 -y
conda activate faceswap

cd ~/git/faceswap/requirements/
pip install -r requirements_cpu.txt

conda deactivate
conda env remove -n faceswap -y

pip install "numpy==1.23.5"
```

# install faceswap gpu - manual
```
cd ~/git
git clone --depth 1 https://github.com/deepfakes/faceswap.git
cd faceswap
conda

conda create -n faceswap python=3.9 -y
conda activate faceswap

cd ~/git/faceswap/requirements/
pip install -r _requirements_base.txt 
pip install "nvidia-ml-py>=12.535,<300"
#pip install tensorflow-gpu==2.10.0
conda install tensorflow=2.10.0

conda install -c conda-forge cudatoolkit=11.2 cudnn=8.1 -y

conda deactivate
conda env remove -n faceswap -y

pip install "numpy==1.23.5"

pip install tensorflow-gpu==2.9.0
python3 -m pip install 'tensorflow[and-cuda]==2.9.0'

python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"

```
