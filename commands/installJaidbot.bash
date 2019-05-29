#!/usr/bin/env bash
set -e
set -o errexit

latestTag=$(latest-github-release --owner jaid --repository jaidbot --tag | tr -d '\r\n')
downloadUrl=https://github.com/Jaid/jaidbot/releases/download/$latestTag/jaidbot_${latestTag}_linux_x64
downloadFile=/usr/local/bin/jaidbot

downloadFile "$downloadUrl" $downloadFile
sudo chmod +x $downloadFile

if [ ! -f /etc/init.d/updateJaidbot ]; then
  sudo installInitd updateJaidbot
fi
