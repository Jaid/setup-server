#!/usr/bin/env bash
set -e
set -o errexit

dockerFolder="$HOME/docker"
projectName=$1
projectFolder="$dockerFolder/$projectName"
composeFile="$projectFolder/docker-compose.yml"

echo "Restarting compose: $1"

docker compose --file "$composeFile" down --remove-orphans --timeout 30
docker compose --file "$composeFile" up --detach
