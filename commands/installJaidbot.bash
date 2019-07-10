#!/usr/bin/env bash
set -e
set -o errexit

latestTag=$(getLatestRepoVersion jaid/jaidbot | tr -d '\r\n')
downloadUrl=https://github.com/Jaid/jaidbot/releases/download/$latestTag/jaidbot_${latestTag}_amd64.deb
downloadFile=/tmp/jaidbot.deb

downloadFile "$downloadUrl" $downloadFile
sudo dpkg --install $downloadFile
sudo aptGet install --fix-broken

sudo ufw allow 9411

mkdir -p /home/jaid/.config/Jaidbot

if [ ! -f /etc/systemd/system/jaidbot.service ]; then
  sudo installService jaidbot
fi
