## create python interpreter
```
python --version
python -m pip install --upgrade pip
REM rmdir /s /q "C:/Users/Vahid/PythonInterpreters"
mkdir "C:/Users/Vahid/PythonInterpreters"

cd "C:/Users/Vahid/PythonInterpreters"
rmdir /s /q jupyter_lab_venv
python -m venv "C:/Users/Vahid/PythonInterpreters/jupyter_lab_venv"
C:\Users\Vahid\PythonInterpreters\jupyter_lab_venv\Scripts\activate
python --version

C:\Users\Vahid\PythonInterpreters\jupyter_lab_venv\Scripts\deactivate

python -m pip install --upgrade pip
pip3 install pipdeptree
pip3 install --upgrade setuptools

pipdeptree -fl

pip3 install jupyterlab
pip3 install numpy==1.23.5
pip3 install sympy 
pip3 install pandas
pip3 install scikit-learn	
pip3 install matplotlib
pip3 install seaborn
pip3 install nltk
pip3 install wordcloud
pip3 install tensorflow[and-cuda]==2.17.1
pip3 install keras
pip3 install torch
pip3 install torchvision
pip3 install torchaudio

C:\Users\Vahid\PythonInterpreters\jupyter_lab_venv\Scripts\activate
python --version
cd %userprofile%/git/codepractice/machine_learning
jupyter lab
C:\Users\Vahid\PythonInterpreters\jupyter_lab_venv\Scripts\deactivate

https://www.tensorflow.org/install/source_windows#tested_build_configurations
nvcc --version
nvidia-smi

```

