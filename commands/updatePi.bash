#!/usr/bin/env bash
set -e
set -o errexit

aptGet update
aptGet dist-upgrade
sudo rpi-update
