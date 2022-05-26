#!/usr/bin/env bash
set -e
set -o errexit

installCompose netdata

cd ~/docker/netdata

docker-compose up

cd ~
