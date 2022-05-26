#!/usr/bin/env bash
set -e
set -o errexit

mkdir -p ~/docker/$1
degit Jaid/setup-server/composes/$1 ~/docker/$1
docker-compose --file ~/docker/$1/docker-compose.yml up --no-start

echo Added docker-compose project: $1
