## install ansible in Ubuntu
```
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

## install semaphore in Ubuntu
```
https://semaphoreui.com/install/binary/2_16/install
sudo dpkg -i semaphore_2.16.18_linux_amd64.deb 
semaphore --version
semaphore setup
semaphore server --config config.json
http://localhost:3000/project/1/history
```