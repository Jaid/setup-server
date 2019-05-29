#!/usr/bin/env bash
set -e
set -o errexit

downloadFile=/etc/init.d/$1
downloadFile https://raw.githubusercontent.com/Jaid/setup-server/master/init.d/$1 $downloadFile
sudo chmod +x $downloadFile

echo Added $downloadFile
