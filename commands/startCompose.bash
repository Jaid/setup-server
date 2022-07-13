#!/usr/bin/env bash
set -e
set -o errexit

dockerFolder="$HOME/docker"
projectName=$1
projectFolder="$dockerFolder/$projectName"
composeFile="$projectFolder/docker-compose.yml"

echo "Starting compose: $1"

docker compose --file "$composeFile" up --detach
