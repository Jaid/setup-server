#!/usr/bin/env bash
set -o errexit
set +o monitor
shopt -s lastpipe

styleRed=$(tput setaf 1)
styleGreen=$(tput setaf 2)
styleBlue=$(tput setaf 6)
stylePink=$(tput setaf 5)
styleGray=$(tput setaf 8)
stylePurple=$(tput setaf 19)
styleOrange=$(tput setaf 172)
styleBold=$(tput bold)
styleReset=$(tput sgr0)

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
    printf "$stylePink%s does not exist, cloning$styleReset\n" "$repoFolder"
    git clone "git@github.com:Jaid/$scriptRepo.git" "$repoFolder"
    git -C "$repoFolder" checkout dist
  else
    printf "$stylePink%s already cloned, pulling$styleReset\n" "$scriptRepo"
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

printf "${styleOrange}Added execute permission to %s scripts$styleReset\n" "$xCount"
printf "${styleOrange}Available scripts: %s$styleReset\n" "$scriptCount"
