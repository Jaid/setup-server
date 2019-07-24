#!/usr/bin/env bash
set -e
set -o errexit

sudo ufw allow 9411

mkdir -p "/home/jaid/.config/Jaidbot"

if [ ! -f /etc/systemd/system/jaidbot.service ]; then
  sudo installService jaidbot
fi
