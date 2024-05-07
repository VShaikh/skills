## Bootable USB

```
sudo -
dmesg
findmnt /dev/sdc
umount /run/media/vahid/PD
dd if=/mnt/Downloads/Software/OS/rhel-9.2-x86_64-boot.iso of=/dev/sdc bs=512k
```
