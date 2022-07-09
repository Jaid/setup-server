#!/usr/bin/env bash

target="$2"
targetFolder="$(dirname "$target")"

if [ ! -d "$targetFolder" ]; then
  echo "Creating folder $targetFolder"
  mkdir --parents "$targetFolder"
fi

sudo curl --fail --silent --header "Cache-Control: no-cache, no-store" --location --retry 3 "https://raw.githubusercontent.com/Jaid/setup-server/master/files/$1?$(date +%s)" --output "$target"

if [ ! -f "$target" ]; then
  echo "Download failed"
  exit 1
fi

sudo chmod +x "$target"
sudo chown "$USER:$USER" "$target"

echo Added "$target"
