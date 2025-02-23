## Install docker
```
#uninstall all conflicting packages
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove --purge $pkg; done

for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get install $pkg; done

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo rm -fr /var/lib/docker

#install
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo docker run hello-world
```

# Install docker-desktop
```
sudo apt install ./docker-desktop-amd64.deb
```

# Fix Docker Desktop in Ubuntu
```
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0
systemctl --user restart docker-desktop
gpg --generate-key
```

# Docker
```
docker login -u <user_name>
docker push <user_name>/<image_name>
docker search <image_name>
docker pull <image_name>

docker build -t <image_name>
docker build -t <image_name> --no-cache
docker images
docker rmi <image_name>
docker image prune
docker system prune -a -f --volumes 

docker run --name <container_name> <image_name>
docker run -p <host_port>:<container_port> <image_name>
docker run -d <image_name>
docker start <container_name>
docker stop <container_name>
docker rm <container_name>
docker exec -it <container_name> sh
docker logs -f <container_name>
docker inspect <container_name>
docker ps
docker ps -all
docker container stats

docker compose down
docker compose up -d --force-recreate
```

## Jenkins
```
docker pull jenkins/jenkins:2.457-jdk11
docker run --name jenkins-service -d -p 8080:8080 -p 50000:50000 -v /data/jenkins:/var/jenkins_home jenkins/jenkins:2.457-jdk11
```

## 