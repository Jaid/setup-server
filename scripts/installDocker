#!/usr/bin/env bash
set -o errexit

mkdir --parents ~/docker
cd ~/docker

curl -fsSL https://get.docker.com -o get-docker.sh
bash get-docker.sh
rm get-docker.sh

enableZshPlugin docker
enableZshPlugin docker-compose

echo "zstyle ':completion:*:*:docker:*' option-stacking yes" >>~/.zshrc
echo "zstyle ':completion:*:*:docker-*:*' option-stacking yes" >>~/.zshrc

sudo usermod -aG docker "$USER"
newgrp docker
