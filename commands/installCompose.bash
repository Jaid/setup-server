#!/usr/bin/env bash
set -o errexit

if [ ! -x "$(command -v degit)" ]; then
  echo "Need command degit"
  exit 1
fi

if [ ! -x "$(command -v docker)" ]; then
  echo "No docker command, installing"
  if [ ! -x "$(command -v installDocker)" ]; then
    echo "Also no installDocker command"
    exit 1
  else
    installDocker
  fi
fi

projectFolder="$HOME/docker/$1"
composeFile="$projectFolder/docker-compose.yml"

if [ -d "$projectFolder" ]; then
  docker compose --file "$composeFile" down --remove-orphans --timeout 30 --rmi local
  backupFolder="$HOME/docker/.backup/$1"
  backupOutput="$backupFolder/$(date "+%Y-%m-%d_%H-%M-%S")"
  echo "Project already exists, moving to $backupOutput"
  mkdir --parents "$backupFolder"
  mv "$projectFolder" "$backupOutput"
else
  mkdir --parents "$projectFolder"
fi

degit "Jaid/setup-server/composes/$1" "$projectFolder"

setupScript="$projectFolder/setup"
if [ -f "$setupScript" ]; then
  chmod +x "$setupScript"
  "$setupScript"
fi

docker compose --file "$composeFile" up --no-start

echo "Added docker-compose project: $1"
echo "Start with:"
echo "docker compose --file '$composeFile' up --detach"
echo "Restart with:"
echo "docker compose --file '$composeFile' down --remove-orphans --timeout 30 && docker compose --file '$composeFile' up --detach"
