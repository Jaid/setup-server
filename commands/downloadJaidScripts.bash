#!/usr/bin/env bash
set -o errexit
set +o monitor
shopt -s lastpipe

if [ -z ${GITHUB_TOKEN+x} ]; then
  printf >&2 'Variable $GITHUB_TOKEN not existing\n'
  exit 1
fi

styleGreen=$(tput setaf 2)
stylePink=$(tput setaf 5)
styleOrange=$(tput setaf 172)
styleReset=$(tput sgr0)

user=${USER:-$(whoami)}
: "${githubUser:="$user"}"
: "${otherReposFolder:="$HOME/src"}"

mkdir --parents "$otherReposFolder"

declare -a scriptRepos=(
  setup-server
  scripts
)
declare -i scriptCount=0
declare -i xCount=0
for scriptRepo in "${scriptRepos[@]}"; do
  printf "${stylePink}Repo: %s$styleReset\n" "$scriptRepo"
  repoFolder="$otherReposFolder/$scriptRepo"
  if [ ! -d "$repoFolder" ]; then
    printf "$stylePink%s does not exist, cloning$styleReset\n" "$repoFolder"
    git clone "https://$githubUser:$GITHUB_TOKEN@github.com/Jaid/$scriptRepo" "$repoFolder"
    git -C "$repoFolder" checkout dist
  else
    printf "$stylePink%s already cloned, pulling$styleReset\n" "$scriptRepo"
    git -C "$repoFolder" fetch
    changeCount=$(git -C "$repoFolder" rev-list "HEAD...origin/$(git -C "$repoFolder" branch --show-current)" --count)
    if [ "$changeCount" -gt 0 ]; then
      printf "${stylePink}New commits: %s$styleReset\n" "$changeCount"
      git -C "$repoFolder" reset --hard origin/dist
    else
      printf "${stylePink}Up to date$styleReset\n"
    fi
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
  git -C "$repoFolder" update-index --assume-unchanged "$repoBinFolder"/*
done

if [ "$xCount" -gt 0 ]; then
  printf "${styleOrange}Added execute permission to %s scripts$styleReset\n" "$xCount"
fi
printf "${styleGreen}Available scripts: %s$styleReset\n" "$scriptCount"
