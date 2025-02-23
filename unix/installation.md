## DEB
```
sudo apt remove --purge docker-desktop
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
