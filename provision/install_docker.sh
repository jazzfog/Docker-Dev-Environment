#! /bin/sh

# Install Docker Engine...

# Doc - https://docs.docker.com/engine/installation/linux/ubuntulinux/

# execute:
# sh -x install_docker.sh

# This script prepared for 14.04 Trusty
# For Ubuntu 16.04 Xenial: Change repo URL

apt-get update

apt-get install apt-transport-https ca-certificates

apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo 'deb https://apt.dockerproject.org/repo ubuntu-trusty main' > /etc/apt/sources.list.d/docker.list

apt-get update

# May be skipped (this package may not exist)
apt-get purge lxc-docker

# Just for debug
apt-cache policy docker-engine

sudo apt-get install linux-image-extra-$(uname -r) -y

# May be skipped (needed for Ubuntu 14.04 or 12.04)
# upd: Looks like not needed anymore
#apt-get install apparmor

apt-get install docker-engine -y

# Not really needed (shoule be already created), but just in case
addgroup docker

# Add users who will use Docker to the `docker` group
usermod -a -G docker vagrant
usermod -a -G docker fog

# Check group
getent group docker
groups vagrant
#cat /etc/group
#cat /etc/group | grep docker
#groups
#groups vagrant

service docker restart

# Install Docker Compose

# Get new version URL here
# https://github.com/docker/compose/releases

curl -L https://github.com/docker/compose/releases/download/1.9.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
