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


