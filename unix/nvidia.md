# check nvidia drivers
```
ubuntu-drivers devices
sudo ubuntu-drivers autoinstall

sudo apt reinstall nvidia-driver-535

nvidia-smi
watch -n 1 nvidia-smi

nvcc -v
```

# install cuda
```
wget https://developer.download.nvidia.com/compute/cuda/11.2.2/local_installers/cuda_11.2.2_460.32.03_linux.run
sudo sh cuda_11.2.2_460.32.03_linux.run
```
