#!/usr/bin/env bash
set -e
set -o errexit

installCompose github-release-writer

cd ~/docker/github-release-writer

mkdir config
docker-compose up
docker-compose down

cd ~
