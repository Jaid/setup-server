#!/usr/bin/env bash
set -e
set -o errexit

latestTag=$(latest-github-release --owner jaid --repository jaidbot --tag | tr -d '\r\n')
downloadUrl=https://github.com/Jaid/jaidbot/releases/download/$latestTag/jaidbot_${latestTag}_amd64.deb
downloadFile=/tmp/jaidbot.deb

downloadFile "$downloadUrl" $downloadFile
sudo dpkg --install $downloadFile
sudo aptGet install --fix-broken

sudo ufw allow 9411
sudo installService jaidbot
