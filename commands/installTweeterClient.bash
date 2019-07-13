#!/usr/bin/env bash
set -e
set -o errexit

latestTag=$(getLatestRepoVersion jaid/tweeter-client | tr -d '\r\n')
downloadUrl=https://github.com/Jaid/tweeter-client/releases/download/$latestTag/tweeter-client_${latestTag}_amd64.deb
downloadFile=/tmp/tweeter-client.deb

downloadFile "$downloadUrl" $downloadFile
sudo dpkg --install $downloadFile
sudo aptGet install --fix-broken

sudo ufw allow 18888
sudo ufw allow 18889

mkdir -p "/home/jaid/.config/Tweeter Client"

if [ ! -f /etc/systemd/system/tweeterClient.service ]; then
  sudo installService tweeterClient
fi
