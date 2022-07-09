#!/usr/bin/env bash
set -e
set -o errexit

target="$2"
targetFolder="$(dirname "$target")"

if [ ! -d "$targetFolder" ]; then
  echo "Creating folder $targetFolder"
  mkdir --parents "$targetFolder"
fi

sudo curl --fail --silent --header 'Cache-Control: no-cache' --location --retry 3 "$1" --output "$target"

if [ ! -f "$target" ]; then
  echo "Download failed"
  exit 1
fi

sudo chown "$USER:$USER" "$target"

echo Added "$target"
