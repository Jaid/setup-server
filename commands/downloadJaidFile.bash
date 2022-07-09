#!/usr/bin/env bash

binFolder=~/bin
mkdir --parents ~/bin
target="$binFolder/$1"

sudo curl --fail --silent --header "Cache-Control: no-cache, no-store" --location --retry 3 "https://raw.githubusercontent.com/Jaid/setup-server/master/files/$1?$(date +%s)" --output "$2"
sudo chmod +x "$target"
echo Added "$target"
