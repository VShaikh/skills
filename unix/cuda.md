# limit gpu
```shell
sudo nano /etc/rc.local

/usr/bin/nvidia-smi -pm 1
/usr/bin/nvidia-smi -pl 70

sudo chmod +x /etc/rc.local


sudo vi /etc/modprobe.d/nvidia-power-management.conf

options nvidia NVreg_EnableGpuFirmware=0
options nvidia NVreg_DynamicPowerManagement=0x00


sudo update-initramfs -u
sudo reboot


```

# setup cuda , cudnn, tensorflow
```
install nvidia driver 470.256.02
sudo sh cuda_11.2.2_460.32.03_linux.run

sudo dpkg -i libcudnn8_8.1.1.33-1+cuda11.2_amd64.deb
sudo dpkg -i libcudnn8-dev_8.1.1.33-1+cuda11.2_amd64.deb
sudo dpkg -i libcudnn8-samples_8.1.1.33-1+cuda11.2_amd64.deb


```