#!/usr/bin/env bash
set -e
set -o errexit

mkdir -p ~/docker
cd ~/docker

curl -fsSL https://get.docker.com -o get-docker.sh
bash get-docker.sh
rm get-docker.sh

enableZshPlugin docker
enableZshPlugin docker-compose

echo "zstyle ':completion:*:*:docker:*' option-stacking yes" >~/.zshrc
echo "zstyle ':completion:*:*:docker-*:*' option-stacking yes" >~/.zshrc
