#!/usr/bin/env bash
set -e
set -o errexit

mkdir -p ~/docker
cd ~/docker

curl -fsSL https://get.docker.com/rootless -o get-docker.sh
bash get-docker.sh
rm get-docker.sh

aptGet install docker-compose

enableZshPlugin docker
enableZshPlugin docker-compose

echo "zstyle ':completion:*:*:docker:*' option-stacking yes" >>~/.zshrc
echo "zstyle ':completion:*:*:docker-*:*' option-stacking yes" >>~/.zshrc
