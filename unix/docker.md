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