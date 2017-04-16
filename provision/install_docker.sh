#! /bin/sh

curl -fsSL https://get.docker.com/ | sh
usermod -a -G docker vagrant

# Install Docker Compose
# Get new version URL here
# https://github.com/docker/compose/releases

curl -L https://github.com/docker/compose/releases/download/1.12.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose