## firewalld
```
sudo apt install firewalld

firewall-cmd --list-all
firewall-cmd --list-all --zone=home
firewall-cmd --list-services
firewall-cmd --list-ports
sudo firewall-cmd --add-port=8983/tcp
sudo firewall-cmd --runtime-to-permanent
sudo firewall-cmd --remove-port=8983/tcp
```
