#!/usr/bin/env bash
set -e
set -o errexit

curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo npm install --global npm date-now-cli open-cli pover replace rimraf yarn json5 getfilesize-cli pkg bin-version-cli npm-check-updates find-by-extension-cli package-name-cli package-field-cli surge foreach-cli

installService updateNpmPackages
