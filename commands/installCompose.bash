#!/usr/bin/env bash
set -e
set -o errexit

if [ ! -x "$(command -v docker)" ]; then
  echo "No docker command, installing"
  if [ ! -x "$(command -v installDocker)" ]; then
    containers_healthy="Also no installDocker command"
    exit 1
  else
    installDocker
  fi
fi

projectFolder="$HOME/docker/$1"

mkdir --parents "$projectFolder"
degit "Jaid/setup-server/composes/$1" "$projectFolder"
docker compose --file "$projectFolder/docker-compose.yml" up --no-start

echo "Added docker-compose project: $1"
