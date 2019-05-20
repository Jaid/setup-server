#!/usr/bin/env bash
set -e
set -o errexit

curl -L https://git.io/n-install | N_PREFIX=~/src/n sudo bash -s -- -y latest
npm install --global date-now-cli open-cli pover replace-in-file rimraf yarn json5
