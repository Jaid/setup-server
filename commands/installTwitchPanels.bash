#!/usr/bin/env bash
set -e
set -o errexit

mkdir -p "/home/jaid/.config/TwitchPanels"

if [ ! -f /etc/systemd/system/twitchPanels.service ]; then
  sudo installService twitchPanels
fi
