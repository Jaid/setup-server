#!/usr/bin/env bash
set -e
set -o errexit

downloadUrl=$(latest-github-release --owner jaid --repository jaidbot --download ".deb" | tr -d '\r\n')
downloadFile=/tmp/jaidbot.deb

downloadFile "$downloadUrl" $downloadFile
sudo dpkg -i $downloadFile
sudo apt-get install --fix-broken
