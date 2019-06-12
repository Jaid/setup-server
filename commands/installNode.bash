#!/usr/bin/env bash
set -e
set -o errexit

curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo npm install --global date-now-cli open-cli pover replace-in-file rimraf yarn json5 latest-github-release getfilesize-cli pkg
