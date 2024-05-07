## Enforce

```
sestatus
getenforce
setenforce 0
sudo vi /etc/selinux/config
#SELINUX=enforcing/permissive/disabled
```

## Enable Extra Packages for Enterprise Linux (EPEL)

```
subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
yum install https://download1.rpmfusion.org/free/el/rpmfusion-free-release-9.noarch.rpm
```

## Enable NTFS for RHEL

Prerequisites: enable EPEL

```
yum install ntfs-3g
```

## Enable Alt+Tab for Chrome in RHEL

go to settings > devices > keyboard
look for the keyboard shortcut for "Switch windows"
set this to the shortcut Alt+Tab (this will overwrite the old shortcut)
If you now press Alt+Tab you will be able to directly select all open windows without grouping into the different apps.

## Softwares in RHEL

```
sudo yum install java-11-openjdk.x86_64
sudo yum install java-11-openjdk-devel.x86_64
chrome
android studio
intellij
yum install vlc
yum install zsh (https://gitlab.com/kalilinux/packages/kali-defaults/-/blob/kali/master/etc/skel/.zshrc)
git
	git config --global user.name "Vahid Shaikh"
	git config --global user.email "meet2vah1d@gmail.com"
webmin
    open port 80 in firewalld
samba
firewall
gimp
```

