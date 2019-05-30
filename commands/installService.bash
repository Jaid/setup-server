#!/usr/bin/env bash
set -e
set -o errexit

downloadFile=/etc/systemd/system/$1.service
downloadFile https://raw.githubusercontent.com/Jaid/setup-server/master/services/$1.service $downloadFile
sudo systemctl daemon-reload
sudo systemctl enable $1.service
sudo service $1 restart

echo Added and started $downloadFile
