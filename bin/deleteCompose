#!/usr/bin/env bash
set -o errexit

dockerFolder="$HOME/docker"
projectName=$1
projectFolder="$dockerFolder/$projectName"
composeFile="$projectFolder/docker-compose.yml"

echo "Stopping compose: $1"
docker compose --file "$composeFile" down --remove-orphans --timeout 30
docker compose --file "$composeFile" rm --volumes --force

echo "Deleting compose: $1"
sudo rm -rf "$projectFolder"
