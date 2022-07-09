#!/usr/bin/env bash
set -e
set -o errexit

projectFolder="$HOME/$1"

mkdir --parents "$projectFolder"
degit "Jaid/setup-server/composes/$1" "$projectFolder"
docker compose --file "$projectFolder/docker-compose.yml" up --no-start

echo "Added docker-compose project: $1"
