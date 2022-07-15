#!/usr/bin/env bash
set -o errexit
set +o monitor
shopt -s lastpipe

if [ ! -x "$(command -v gitClone)" ]; then
  echo "Need command gitClone"
  exit 1
fi

repoFolder="$HOME/src/setup-server"
inputFolder="$repoFolder/commands"
outputFolder="$HOME/bin"

if [ ! -d "$repoFolder" ]; then
  echo "$repoFolder does not exist, cloning"
  gitClone Jaid/setup-server
else
  git pull --ff-only --quiet -C "$repoFolder"
fi

declare -i allCount=0
declare -i changedCount=0

find "$inputFolder" -type f -printf '%f\n' | while read -r file; do
  scriptName=$(printf %s "$file" | sed 's|\.\w\+$||')
  inputFile="$inputFolder/$file"
  outputFile="$outputFolder/$scriptName"
  if [ -f "$outputFile" ]; then
    inputMd5=$(md5sum "$inputFile" | cut --fields 1 --delimiter " ")
    outputMd5=$(md5sum "$outputFile" | cut --fields 1 --delimiter " ")
    if [ "$inputMd5" != "$outputMd5" ]; then
      echo "Updating: $scriptName"
      cp --no-preserve=mode,ownership "$inputFile" "$outputFile"
      ((++changedCount))
    fi
  else
    echo "Adding: $scriptName"
    cp "$inputFile" "$outputFile"
    ((++changedCount))
  fi
  ((++allCount))
done

printf 'Updated %s/%s scripts\n' "$changedCount" "$allCount"
