#!/usr/bin/env bash
set -e
set -o errexit

target="$2"

sudo curl --fail --silent --header 'Cache-Control: no-cache' --location --retry 3 "$1" --output "$target"

if [ ! -f "$target" ]; then
  "Download failed"
  exit 2
fi

sudo chown "$USER:$USER" "$target"

echo Added "$target"
