#!/usr/bin/env bash
set -o errexit

curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
requireAptPackages build-essential pkg-config gcc g++ make python3
aptGet clean
aptGet autoremove
aptGet install nodejs

sudo npm install --global npm
sudo npm install --global node-gyp
sudo npm install --global replace json5 bin-version-cli find-by-extension-cli package-name-cli package-field-cli jaid-logger-tail
