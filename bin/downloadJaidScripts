#!/usr/bin/env bash
set -o errexit
set +o monitor
shopt -s lastpipe

: "${otherReposFolder:="$HOME/src"}"
mkdir --parents "$otherReposFolder"

declare -a scriptRepos=(
  setup-server
  scripts
)
declare -i scriptCount=0
declare -i xCount=0
for scriptRepo in "${scriptRepos[@]}"; do
  printf 'Repo: “%s”\n' "$scriptRepo"
  repoFolder="$otherReposFolder/$scriptRepo"
  if [ ! -d "$repoFolder" ]; then
    printf "%s does not exist, cloning\n" "$repoFolder"
    git clone "git@github.com:Jaid/$scriptRepo.git" "$repoFolder"
    git -C "$repoFolder" checkout dist
  else
    git -C "$repoFolder" pull --ff-only --quiet
  fi
  repoBinFolder="$repoFolder/bin"
  find "$repoBinFolder" -type f -printf '%f\0' | while read -r -d $'\0' file; do
    ((scriptCount++)) || true
    fullPath="$repoBinFolder/$file"
    if [ ! -x "$fullPath" ]; then
      chmod +x "$fullPath"
      ((xCount++)) || true
    fi
  done
done

printf 'Added execute permission to %s scripts\n' "$xCount"
printf 'Available scripts: %s\n' "$scriptCount"
