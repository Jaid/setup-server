#!/usr/bin/env bash
set -o errexit

requireAptPackages openssh-server
installGist e4673390a04dd0ce2fe4dc4c4c7ed592
sudo systemctl enable ssh
sudo service ssh start
