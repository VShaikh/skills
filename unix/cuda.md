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
