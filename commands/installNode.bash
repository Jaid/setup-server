#!/usr/bin/env bash
set -e
set -o errexit

gitClone nvm-sh/nvm
source ~/src/nvm/nvm.sh
nvm install node

npm install --global date-now-cli open-cli pover replace-in-file rimraf yarn json5
