#!/usr/bin/env bash
set -e
set -o errexit

dockerFolder="$HOME/docker"
projectName=$1
projectFolder="$dockerFolder/$projectName"
composeFile="$projectFolder/docker-compose.yml"

echo "Restarting and upgrading compose: $1"

docker compose --file "$composeFile" down --remove-orphans --timeout 30
# docker compose --file "$composeFile" rm --force Looks like this is not needed
docker compose --file "$composeFile" pull
docker compose --file "$composeFile" up --build --detach
