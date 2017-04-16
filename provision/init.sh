#!/usr/bin/env bash

apt-get update
apt-get install htop mc -y

. /vagrant/provision/install_docker.sh
