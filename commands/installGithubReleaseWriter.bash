#!/usr/bin/env bash
set -e
set -o errexit

# sudo ufw allow 39410
# sudo ufw allow 39411

installCompose github-release-writer

cd ~/docker/github-release-writer

mkdir config
touch config/config.yml
touch config/secrets.yml

cd ~
