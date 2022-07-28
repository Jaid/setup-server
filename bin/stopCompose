#!/usr/bin/env bash
set -o errexit

dockerFolder="$HOME/docker"
projectName=$1
projectFolder="$dockerFolder/$projectName"
composeFile="$projectFolder/docker-compose.yml"

echo "Stopping compose: $1"

docker compose --file "$composeFile" down --remove-orphans --timeout 30
