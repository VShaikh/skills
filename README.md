## Environments and aliases

```
export PATH=/home/vahid/Android/Sdk/platform-tools:$PATH
export PATH=/opt/flutter/bin:$PATH
sstatus(){
  sudo systemctl status $1
}
sstart(){
  sudo systemctl start $1
}
sstop(){
  sudo systemctl stop $1
}
srestart(){
  sudo systemctl stop $1
  sudo systemctl start $1
}
sshow(){
  sudo systemctl show $1
}
slog(){
  if [ -z "$1" ]; then
    journalctl -f
  else
    journalctl -f -u $1
  fi
}
```

## Unix systemd logs

https://www.digitalocean.com/community/tutorials/how-to-use-journalctl-to-view-and-manipulate-systemd-logs

```
journalctl
journalctl -b
journalctl --since yesterday
journalctl --since "2015-01-10 17:15:00"
journalctl --since "2015-01-10" --until "2015-01-11 03:00"
journalctl --since 09:00 --until "1 hour ago"
journalctl -u mytubeweb.service
journalctl -u mytubeweb.service -u mysqld.service --since today
journalctl _PID=8088
id -u www-data
journalctl _UID=33 --since today
journalctl -F _GID
journalctl /usr/bin/bash
journalctl -k
journalctl -k -b -5
journalctl -p err -b
journalctl -n 20
journalctl -f
journalctl -f -u mytubeweb.service
```

## Desktop shortcuts

```
sudo ln -s /opt/idea-IC-232.9559.62 /opt/intellij
sudo vi /usr/bin/intellij
#!/bin/bash
cd /opt/intellij/bin/
/bin/bash ./idea.sh

sudo gedit /usr/share/applications/intellij.desktop
[Desktop Entry]
Version=2023.2.1
Name=IntelliJ
GenericName=IDE
Exec=/usr/bin/intellij %u
Icon=/opt/intellij/bin/idea.png
Terminal=false
Type=Application
MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
Categories=Network;WebBrowser;
Keywords=web;browser;internet;
Actions=new-window;new-private-window;profile-manager-window;

X-Desktop-File-Install-Version=0.26

[Desktop Action new-window]
Name=Open a New Window
Exec=intellij --new-window %u

sudo vi /usr/bin/studio
#!/bin/bash
cd /opt/android-studio/bin
/bin/bash ./studio.sh

sudo gedit /usr/share/applications/studio.desktop
[Desktop Entry]
Version=2023.2.1
Name=Android Studio
GenericName=IDE
Exec=studio %u
Icon=/opt/android-studio/bin/studio.svg
Terminal=false
Type=Application
MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
Categories=Network;WebBrowser;
Keywords=web;browser;internet;
Actions=new-window;new-private-window;profile-manager-window;

X-Desktop-File-Install-Version=0.26

[Desktop Action new-window]
Name=Open a New Window
Exec=studio --new-window %u
 

sudo gedit /usr/share/applications/jdownloader2.desktop
[Desktop Entry]
Version=2.0
Name=JDownloader
GenericName=IDE
Exec=jdownloader2 %u
Icon=/opt/jdownloader2/themes/standard/org/jdownloader/images/logo/jd_logo_128_128.png
Terminal=false
Type=Application
MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
Categories=Network;WebBrowser;
Keywords=web;browser;internet;
Actions=new-window;new-private-window;profile-manager-window;

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

## Create systemd / systemctl service for mytubeweb

```
sudo gedit /etc/systemd/system/mytubeweb.service

[Unit]
Description=Gunicorn daemon for MyTubeWeb
After=network.target

[Service]
User=root
Group=root
WorkingDirectory=/home/vahid/git/mytubeweb
ExecStart=/home/vahid/python-interpreters/mytubeweb_venv/bin/gunicorn --workers 17 -threads 2 --bind 0.0.0.0:80 -m 007 mytubeweb.wsgi --log-level warn --access-logfile /var/log/mytubeweb_access.log --error-logfile /var/log/mytubeweb_error.log

[Install]
WantedBy=multi-user.target


sudo systemctl daemon-reload
setenforce 0

open port 80 in firewalld
```

## Enforce

```
sestatus
getenforce
setenforce 0
sudo vi /etc/selinux/config
#SELINUX=enforcing/permissive/disabled
```

## Setup systemd / systemctl commands

```
vi /etc/systemd/system/mytubeweb.service

sudo systemctl daemon-reload
sudo systemctl start mytubeweb.service
sudo systemctl stop mytubeweb.service
sudo systemctl status mytubeweb.service
sudo systemctl show mytubeweb.service
```

## System information

```
lscpu
lsblk
lsblk --fs
lspci
lsusb
free -m
free -mh
dmidecode -t
dmidecode -t bios
dmidecode -t system
hwinfo
```

## Setup postfix

```
#Gmail settings: https://support.google.com/mail/answer/7126229?hl=en#zippy=%2Cstep-change-smtp-other-settings-in-your-email-client
yum install postfix

#configure /etc/postfix/main.cf
relayhost = [smtp.gmail.com]:587
smtp_sasl_auth_enable = yes 
smtp_sasl_security_options = noanonymous 
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_tls_CAfile = /etc/ssl/certs/ca-bundle.crt
smtp_use_tls = yes
inet_protocols = ipv4

#steps to generate app password: https://support.google.com/accounts/answer/185833?sjid=2460604110526822821-AP#zippy=%2Cwhy-you-may-need-an-app-password

#configure /etc/postfix/sasl_passwd
[smtp.gmail.com]:587 service.alerts.noreply@gmail.com:<app-password>

cd /etc/postfix/
sudo postmap sasl_passwd

sudo systemctl restart postfix

echo "This is a test email." | mail -r service.alerts.noreply@gmail.com -s "Test email" meet2vah1d@gmail.com

sendmail meet2vah1d@gmail.com
From: service.alerts.noreply@gmail.com
Subject: Test mail
This is a test email
.

```

## Bootable USB

```
sudo -
dmesg
findmnt /dev/sdc
umount /run/media/vahid/PD
dd if=/mnt/Downloads/Software/OS/rhel-9.2-x86_64-boot.iso of=/dev/sdc bs=512k
```

## Enable sudo for a user

```
usermod -aG wheel marlena
vi /etc/sudoers
#vahid   ALL=(ALL)       ALL
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
```

## Install jenkins

```
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum install jenkins

sudo -u jenkins /bin/bash
cd ~/.ssh/
#copy all private and public keys
#run git clone command and verify host key
```

## Create cron job

```
#In every minute, run a script to move APK files.
sudo crontab -e
*/1 * * * * /home/vahid/move_jenkins_build_to_gdrive.sh

cat /home/vahid/move_jenkins_build_to_gdrive.sh
cp /home/vahid/JenkinsBuild/*.apk /run/user/1000/gvfs/google-drive:host=gmail.com,user=meet2vah1d/0APAO6407KJdjUk9PVA/1br-LlPzDej_pI2oDGGDPdrxiPbmKh1jp && rm -f /home/vahid/JenkinsBuild/*.apk
```

## Install HP printer software (facing issues)

```
https://developers.hp.com/hp-linux-imaging-and-printing/gethplip
sudo rpm -ivh --force --nodeps hplip-3.23.8-RHEL9-x86_64.rpm

```

## Install Solr

```
cd /opt/solr/bin
./solr create -c mytube -n data_driven_schema_configs

```

## Create systemd / systemctl service for Solr

```
sudo gedit /etc/systemd/system/solr.service

[Unit]
Description=Solr Service
After=network.target

[Service]
User=vahid
WorkingDirectory=/opt/solr/bin/
PIDFile=/opt/solr/bin/solr-8983.pid
ExecStart=/opt/solr/bin/solr start
ExecStop=/opt/solr/bin/solr stop
StandardOutput = file:/opt/solr/bin/stdout.log

[Install]
WantedBy=multi-user.target


sudo systemctl daemon-reload
setenforce 0

open port 8983 in firewalld

sudo systemctl daemon-reload
sudo systemctl start solr.service
sudo systemctl stop solr.service
sudo systemctl status solr.service
sudo systemctl show solr.service
```

## Create systemd / systemctl service for mytubewe_zio

```
sudo gedit /etc/systemd/system/mytubewebz.service

[Unit]
Description=Process for MyTubeWeb ZIO
After=network.target

[Service]
User=root
Group=root
WorkingDirectory=/opt/mytubeweb/bin
ExecStart=/opt/mytubeweb/bin/mytubeweb-zio

[Install]
WantedBy=multi-user.target

sudo systemctl daemon-reload
sudo systemctl enable mytubewebz.service
setenforce 0

open port 80 in firewalld
```

## Install 7zip

```
sudo yum -y install p7zip
7za e <archive name>
7za x <archive name>
```

## Install Anaconds

```
sudo yum install libXcomposite libXcursor libXi libXtst libXrandr alsa-lib mesa-libEGL libXdamage mesa-libGL libXScrnSaver
cd ~/Downloads
curl -O https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh
bash ./Anaconda3-2024.02-1-Linux-x86_64.sh
source /home/vahid/anaconda3/bin/activate
jupyter notebook
```

## Setup firebase

```
curl -sL https://firebase.tools | bash
firebase login
firebase projects:list
dart pub global activate flutterfire_cli
~/.pub-cache/bin/flutterfire configure 
firebase logout
firebase login
```

## SSH

```
ssh-keygen -t rsa
```

## Docker

```
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
sudo docker run hello-world
cd ~/Downloads
wget https://desktop.docker.com/linux/main/amd64/145265/docker-desktop-4.29.0-x86_64.rpm?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64
sudo dnf install ./docker-desktop-<version>-<arch>.rpm
systemctl --user enable docker-desktop
systemctl --user stop docker-desktop

gpg --generate-key
Vahid meet2vah1d@gmail.com
pub   ed25519 2024-05-05 [SC] [expires: 2027-05-05]
663B37B89A5AB3D775A5AFA9C30C90B9A4BE1FF6
uid                      Vahid <meet2vah1d@gmail.com>
sub   cv25519 2024-05-05 [E] [expires: 2027-05-05]

pass init 663B37B89A5AB3D775A5AFA9C30C90B9A4BE1FF6

sudo dnf remove docker-desktop
sudo dnf install ./docker-desktop-<version>-<arch>.rpm
```

## Snapd

```
sudo dnf install snapd
sudo ln -s /var/lib/snapd/snap /snap
```

## HP Print

```
sudo snap install hp-printer-app
Defailt wiki direct password: 12345678
```

## Java
```
sudo dnf install java-1.8.0-openjdk-1:1.8.0.402.b06-2.fc40.x86_64 
```

## firewalld
```
firewall-cmd --list-all
firewall-cmd --list-all --zone=home
firewall-cmd --list-services
firewall-cmd --list-ports
sudo firewall-cmd --add-port=8983/tcp
sudo firewall-cmd --runtime-to-permanent
sudo firewall-cmd --remove-port=8983/tcp
```
