#!/usr/bin/env bash
set -o errexit

dockerFolder="$HOME/docker"
projectName=$1
projectFolder="$dockerFolder/$projectName"
composeFile="$projectFolder/docker-compose.yml"

echo "Restarting and upgrading compose: $1"

docker compose --file "$composeFile" down --remove-orphans --timeout 30 --rmi all
docker compose --file "$composeFile" pull
docker compose --file "$composeFile" up --build --detach
