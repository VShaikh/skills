## Install jenkins

```shell
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum install jenkins

sudo -u jenkins /bin/bash
cd ~/.ssh/
#copy all private and public keys
#run git clone command and verify host key


/etc/systemd/system/multi-user.target.wants/jenkins.service


sudo chown -R vahid:vahid /var/log/jenkins
sudo chown -R vahid:vahid /var/lib/jenkins
sudo chown -R vahid:vahid /var/run/jenkins
sudo chown -R vahid:vahid /var/cache/jenkins

```
