#!/usr/bin/env bash
set -e
set -o errexit

mkdir -p ~/docker/$1

downloadFile=~/docker/$1/docker-compose.yml
downloadFile https://raw.githubusercontent.com/Jaid/setup-server/master/composes/$1/docker-compose.yml $downloadFile

cd ~/docker/$1

if ! id -nG "$USER" | grep -qw "docker"; then
  echo "Adding user $USER to group docker"
  sudo usermod -aG docker $USER
  newgrp docker
fi

echo Added and started $downloadFile
cd ~
