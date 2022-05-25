#!/usr/bin/env bash
set -e
set -o errexit

mkdir -p ~/docker/$1

downloadFile=~/docker/$1/docker-compose.yml
downloadFile https://raw.githubusercontent.com/Jaid/setup-server/master/composes/$1.service $downloadFile

cd ~/docker/$1
docker-compose build

echo Added and started $downloadFile
cd ~
