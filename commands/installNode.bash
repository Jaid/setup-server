#!/usr/bin/env bash
set -e
set -o errexit

aptGet install build-essential

curl -fsSL https://deb.nodesource.com/setup_current.x | bash -
aptGet install nodejs

sudo npm install --global npm replace rimraf json5 getfilesize-cli pkg bin-version-cli find-by-extension-cli package-name-cli package-field-cli jaid-logger-tail degit
