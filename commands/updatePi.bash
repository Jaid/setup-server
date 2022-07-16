#!/usr/bin/env bash
set -e
set -o errexit

if [ "$1" = 'dry' ]; then
  aptGet update
  aptGet --simulate upgrade
  sudo JUST_CHECK=1 SKIP_WARNING=1 rpi-update
else
  aptGet update
  aptGet full-upgrade
  sudo PRUNE_MODULES=1 RPI_REBOOT=1 SKIP_WARNING=1 rpi-update
fi
