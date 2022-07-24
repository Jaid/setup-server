#!/usr/bin/env bash
set -o errexit

configFolder="$HOME/.config/nano"
rcFile="$configFolder/nanorc"
repo=scopatz/nanorc
repoFolder="$HOME/src/$repo"

mkdir --parents "$configFolder"
aptGet install nano

if [ ! -d "$repoFolder" ]; then
  echo "$repoFolder does not exist, cloning"
  gitClone $repo
else
  git -C "$repoFolder" pull --ff-only --quiet
fi

addSyntax() {
  printf 'include "%s/%s.nanorc"\n' "$repoFolder" "$1" >>"$rcFile"
}

addSyntax c
addSyntax conf
addSyntax css
addSyntax html
addSyntax ini
addSyntax js
addSyntax json
addSyntax markdown
addSyntax patch
addSyntax properties
addSyntax sh
addSyntax sql
addSyntax systemd
addSyntax ts
addSyntax xml
addSyntax yaml
addSyntax zsh
