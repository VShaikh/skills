# install jdk
sudo apt install openjdk-21-jdk

# create ssh key
ssh-keygen -t rsa

# clone git repos
git clone git@github.com:VShaikh/skills.git
git clone git@gitlab.com:mytube/mytube-web-fastapi-solr.git
git clone git@gitlab.com:mytube/mytube-app-flutter-python
git clone git@gitlab.com:mytube/mytube-web-python
git clone git@gitlab.com:mytube/mytube-web-zio
git clone git@gitlab.com:mytube/mytube-app-flutter-zio

# insall android studio
tar -xvzf android-studio-2025.1.2.12-linux.tar.gz
sudo mv android-studio-2025.1.2.12-linux.tar.gz /opt/
sudo chmod 755 /opt/android-studio -R
sudo chown vahid:vahid /opt/android-studio -R

# install flutter
tar -xvf flutter_linux_3.35.1-stable.tar.xz
sudo mv flutter /opt/
sudo chmod 755 /opt/flutter -R
sudo chown vahid:vahid /opt/flutter -R

# install IntelliJ Idea
tar -xvzf ideaIC-2025.2.tar.gz 
sudo mv idea-IC-252.23892.409 /opt/
sudo ln -s /opt/idea-IC-252.23892.409 /opt/idea
sudo chmod 755 /opt/idea -R
sudo chown vahid:vahid /opt/idea -R

# install sublime
sudo dpkg -i sublime-text_build-4200_amd64.deb

# install postman
sudo mv Postman /opt/
sudo chmod 755 /opt/Postman -R
sudo chown vahid:vahid /opt/Postman -R

cat <<EOF > /tmp/postman.desktop
[Desktop Entry]
Version=1.0
Name=Postman
Comment=Postman Desktop
Exec=/opt/Postman/Postman
Path=/opt/Postman/
Icon=/opt/Postman/app/icons/icon_128x128.png
Terminal=false
Type=Application

EOF

sudo mv /tmp/postman.desktop /usr/share/applications/

# install solr
tar -xvzf solr-9.9.0.tgz
sudo mv solr-9.9.0 /opt/
sudo ln -s /opt/solr-9.9.0 /opt/solr
sudo chmod 755 /opt/solr -R
sudo chown vahid:vahid /opt/solr -R
