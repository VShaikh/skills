# install jdk
```
sudo apt install openjdk-21-jdk
```
# create ssh key
```
ssh-keygen -t rsa
```
# clone git repos
```
git config --global user.name "Vahid Shaikh"
git config --global user.email "meet2vah1d@gmail.com"

cd /home/vahid/git
git clone git@github.com:VShaikh/skills.git
git clone git@github.com:VShaikh/flutter_utils.git
git clone git@github.com:VShaikh/flu_console.git
git clone git@gitlab.com:vs-utils/coding-practice.git
git clone git@gitlab.com:mytube/mytube-web-fastapi-solr.git
git clone git@gitlab.com:mytube/mytube-app-flutter-python
git clone git@gitlab.com:mytube/mytube-web-python
git clone git@gitlab.com:mytube/mytube-web-zio
git clone git@gitlab.com:mytube/mytube-app-flutter-zio
git clone git@gitlab.com:mytube/mytube-app-flutter-zio-hig
git clone git@gitlab.com:vs-utils/utils-python.git
git clone git@gitlab.com:vs-utils/opencv-utils-python.git
git clone git@gitlab.com:vs-utils/opencv-utils-scala.git
git clone git@gitlab.com:vs-utils/common-utils-python.git
git clone git@gitlab.com:vs-utils/media-utils-python.git
```
# insall android studio
```
tar -xvzf android-studio-*.tar.gz
sudo mv android-studio /opt/
sudo chmod 755 /opt/android-studio -R
sudo chown vahid:vahid /opt/android-studio -R
```
# install flutter
```
tar -xvf flutter_linux_3.38.2-stable.tar.xz
sudo mv flutter /opt/
sudo chmod 755 /opt/flutter -R
sudo chown vahid:vahid /opt/flutter -R
```
# install IntelliJ Idea
```
tar -xvzf ideaIC-2025.2.4.tar.gz
sudo mv idea-IC-252.27397.103 /opt/
sudo ln -s /opt/idea-IC-252.27397.103 /opt/idea
sudo chmod 755 /opt/idea -R
sudo chown vahid:vahid /opt/idea -R
```
# install sublime
```
sudo dpkg -i sublime-text_build-4200_amd64.deb
```
# install postman
```
tar -xvzf postman-linux-x64.tar.gz
sudo mv Postman /opt/
sudo chmod 755 /opt/Postman -R
sudo chown vahid:vahid /opt/Postman -R

wget -D /opt/Postman/icon.png https://www.svgrepo.com/show/354202/postman-icon.svg
mv /opt/Postman/postman-icon.svg /opt/Postman/icon.png

cat <<EOF > /tmp/postman.desktop
[Desktop Entry]
Version=1.0
Name=Postman
Comment=Postman Desktop
Exec=/opt/Postman/Postman
Path=/opt/Postman/
Icon=/opt/Postman/icon.png
Terminal=false
Type=Application

EOF

sudo mv /tmp/postman.desktop /usr/share/applications/
```
# install solr
```
tar -xvzf solr-9.9.0.tgz
sudo mv solr-9.9.0 /opt/
sudo ln -s /opt/solr-9.9.0 /opt/solr
sudo chmod 755 /opt/solr -R
sudo chown vahid:vahid /opt/solr -R
```
# install pycharm
```
tar -xvzf pycharm-2025.2.4.tar.gz
sudo mv pycharm-2025.2.4 /opt/
sudo ln -s /opt/pycharm-2025.2.4 /opt/pycharm
sudo chmod 755 /opt/pycharm -R
sudo chown vahid:vahid /opt/pycharm -R
```

# setup profile
```
ln -s ~/git/skills/unix/scripts ~/scripts
mkdir -p /home/vahid/.config/pip/
cd scripts
./setup_profile.sh
```

# miniconda
```
./Miniconda3-latest-Linux-x86_64.sh
conda
conda tos accept
```

## create systemd / systemctl service for pypi
```shell
conda
conda create -n pypi python=3.12.0 -y
conda activate pypi
python -m pip install --upgrade pip
python -m pip install pypiserver
mkdir -p /home/vahid/.pypi_packages
```
```shell
sudo gedit /etc/systemd/system/pypi.service

[Unit]
Description=Process for PyPi Server
After=network.target

[Service]
User=vahid
Group=vahid
WorkingDirectory=/home/vahid/miniconda3/envs/pypi/bin/
ExecStart=/home/vahid/miniconda3/envs/pypi/bin/pypi-server run -p 8090 ~/.pypi_packages/

[Install]
WantedBy=multi-user.target

sudo systemctl daemon-reload
sudo systemctl enable pypi.service

srestart pypi
```
