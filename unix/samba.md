## Install samba

```
sudo yum install samba
open port 445 in firewalld
sudo systemctl enable smb
sudo systemctl start smb
sudo gedit /etc/samba/smb.conf

[movies]
	comment = Movies
	path = /mnt/Entertainment/Movies/
	browseable = Yes
	read only = No

[videos]
	comment = Videos
	path = /mnt/Entertainment/Videos/
	browseable = Yes
	read only = No

sudo ufw allow samba
sudo smbpasswd -a vahid
```

```
smbclient -L //192.168.1.1 -N --option='client min protocol=NT1' --option='client max protocol=NT1'
sudo mkdir -p /mnt/tplink_usb
sudo mount -t cifs //192.168.1.1/sda1 /mnt/tplink_usb -o guest,vers=1.0
df -h | grep tplink
ls /mnt/tplink_usb

```