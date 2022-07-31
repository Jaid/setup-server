#!/usr/bin/env bash
set -o errexit

curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
requireAptPackages gcc g++ make build-essential
aptGet clean
aptGet autoremove
aptGet install nodejs

sudo npm install --global npm
sudo npm install --global node-gyp
sudo npm install --global npm replace rimraf json5 getfilesize-cli pkg bin-version-cli find-by-extension-cli package-name-cli package-field-cli jaid-logger-tail degit
