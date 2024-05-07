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
