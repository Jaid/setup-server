#!/usr/bin/env bash
set -e
set -o errexit

downloadUrl=$(npx latest-github-release --owner jaid --repository jaidbot --download ".deb")
downloadFile=/tmp/jaidbot.deb

downloadFile "$downloadUrl" $downloadFile
sudo dpkg -i $downloadFile
sudo apt-get install --fix-broken
