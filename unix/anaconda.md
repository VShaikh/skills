## Install Anaconda

```
apt-get install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6
cd ~/Downloads
curl -O https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh
bash ./Anaconda3-2019.03-Linux-x86_64.sh
source /home/vahid/anaconda3/bin/activate
cd ~/git/codepractice/machine_learning/practice
jupyter notebook

anaconda-navigator
#conda install anaconda-navigator

conda update anaconda-navigator

conda install pip

conda config --remove channels conda-forge
conda config --add channels conda-forge

conda update conda

conda install anaconda-clean --yes
conda clean --all --yes

conda install -c conda-forge tensorflow
conda install tensorflow

conda install -n base -c conda-forge mamba


```
 