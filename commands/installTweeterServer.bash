#!/usr/bin/env bash
set -e
set -o errexit

latestTag=$(getLatestRepoVersion jaid/tweeter-server | tr -d '\r\n')
downloadUrl=https://github.com/Jaid/tweeter-server/releases/download/$latestTag/tweeter-server_${latestTag}_amd64.deb
downloadFile=/tmp/tweeter-server.deb

downloadFile "$downloadUrl" $downloadFile
sudo dpkg --install $downloadFile
sudo aptGet install --fix-broken

sudo ufw allow 18888
sudo ufw allow 18889

mkdir -p "/home/jaid/.config/Tweeter Server"

if [ ! -f /etc/systemd/system/tweeterServer.service ]; then
  sudo installService tweeterServer
fi
