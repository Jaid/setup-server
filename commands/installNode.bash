#!/usr/bin/env bash
set -e
set -o errexit

curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
aptGet install nodejs
sudo npm install --global --unsafe-perm npm date-now-cli open-cli pover replace rimraf yarn json5 getfilesize-cli pkg bin-version-cli npm-check-updates find-by-extension-cli package-name-cli package-field-cli surge foreach-cli jaid-logger-tail

installService updateNpmPackages
