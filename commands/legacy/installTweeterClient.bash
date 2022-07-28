#!/usr/bin/env bash
set -o errexit

# sudo ufw allow 18888
# sudo ufw allow 18889

mkdir -p "/home/jaid/.config/Tweeter Client"

if [ ! -f /etc/systemd/system/tweeterClient.service ]; then
  sudo installService tweeterClient
fi
