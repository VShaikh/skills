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

# trust an ip address
```
sudo firewall-cmd --permanent --zone=trusted --add-source=192.168.1.102
sudo firewall-cmd --reload
```

# trust whole subnet
```
sudo firewall-cmd --permanent --zone=trusted --add-source=192.168.1.0/24
sudo firewall-cmd --reload
```

# install gui
```
sudo apt install firewall-config
sudo apt install firewalld
```