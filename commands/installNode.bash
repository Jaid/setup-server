#!/usr/bin/env bash
set -e
set -o errexit

executeDownload "https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh"
nvm install node
nvm use node

npm install --global date-now-cli open-cli pover replace-in-file rimraf yarn
