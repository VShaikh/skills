# install faceswap - auto
```

cd ~/Downloads
wget https://github.com/deepfakes/faceswap/releases/download/v2.10.0/faceswap_setup_x64.sh
#https://github.com/deepfakes/faceswap/releases

conda install -c conda-forge tensorflow-gpu cudatoolkit=11.2 cudnn=8.1

```

# install faceswap - manual
```
cd ~/git
git clone --depth 1 https://github.com/deepfakes/faceswap.git
cd faceswap
conda

conda create -n faceswap python=3.10 -y
conda activate faceswap

cd requirements/
pip install -r _requirements_base.txt 
pip install "nvidia-ml-py>=12.535,<300"
pip install "tensorflow==2.10.0"
pip install "numpy==1.23.5"
conda install -c conda-forge cudatoolkit=11.2 cudnn=8.1
```
