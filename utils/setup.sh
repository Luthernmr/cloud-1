#!/usr/bin/env bash 
sudo dnf update
sudo dnf install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker ec2-user
newgrp docker

mkdir -p /mnt/efs
mkdir -p "/mnt/efs/${VOLUME_NAME}"
mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport "${EFS_DNS_NAME}:/" "/mnt/efs/${VOLUME_NAME}"

sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo  docker-compose -f /app/docker-compose.yml up -d
