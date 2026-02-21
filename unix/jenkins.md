## Install jenkins

```shell
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins -y
```

## Make jenkins to run as root or any other user
```shell
sudo vi /etc/sudoers.d/jenkins
jenkins ALL=(ALL) NOPASSWD: ALL

sudo su jenkins
sudo -l
```
