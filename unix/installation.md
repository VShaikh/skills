## host a deb pacakge in local
```
sudo apt update
sudo apt install dpkg-dev

mkdir ~/my-local-repo
cp <example>.deb ~/my-local-repo

chmod +x /home/vahid
chmod +x /home/vahid/my-local-repo
chmod 644 /home/vahid/my-local-repo/Packages*
chmod 644 /home/vahid/my-local-repo/*.deb

echo "deb [trusted=yes] file:/home/$USER/my-local-repo ./" | sudo tee /etc/apt/sources.list.d/my-local-repo.list

cd ~/my-local-repo
dpkg-scanpackages . /dev/null > Packages
gzip -9c Packages > Packages.gz
zstd -19 Packages -o Packages.zst
```

## DEB
```
sudo apt remove --purge docker-desktop
apt-cache depends vim
```

## RPM / YUM

```
rpm -i <file.rpm>
rpm -U <file.rpm>
rpm -qa | grep mysql
dnf -y install mysql
yum repolist
yum repolist
yum list installed
yum list available
yum search java
yum info bind
yum check-update
yum update <package>
yum remove <package>
yum update
yum clean all
yum-config-manager --disable repository
yum-config-manager --add-repo http://www.example.com/example.repo
yum --disablerepo=some-repository install some-package
yum list all --showduplicates
package-cleanup --dupes
package-cleanup --problems

```
