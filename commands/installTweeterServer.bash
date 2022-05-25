#!/usr/bin/env bash
set -e
set -o errexit

# sudo ufw allow 18888
# sudo ufw allow 18889

mkdir -p "/home/jaid/.config/Tweeter Server"

if [ ! -f /etc/systemd/system/tweeterServer.service ]; then
  sudo installService tweeterServer
fi
