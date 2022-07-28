#!/usr/bin/env bash
set -o errexit

: "${otherReposFolder:="$HOME/src"}"

requireAptPackages git

cd "$HOME" # It's safer: https://stackoverflow.com/questions/9851644/git-pulling-depends-on-the-current-dir

if [[ $1 =~ .*:.* ]]; then # if is url
  repositoryUrl="$1"
else
  repositoryUrl="https://github.com/$1"
fi
if [ $# -ge 3 ]; then
  destinationFolder=$3
  destinationParentFolder=$(dirname "$destinationFolder")
else
  repositoryName=${repositoryUrl##*/}
  destinationFolder=$otherReposFolder/$repositoryName
  destinationParentFolder=$otherReposFolder
fi
printf 'Using base folder: %s\n' "$destinationParentFolder"
mkdir --parents "$destinationParentFolder"
if [ -d "$destinationFolder" ]; then
  cd "$destinationFolder"
  git pull || true
else
  git clone "$repositoryUrl" "$destinationFolder"
  cd "$destinationFolder"
fi
if [ $# -ge 2 ]; then
  branch=$2
  if [ "$branch" = "release" ]; then
    git checkout "$(git tag | tail -1)"
  elif [ "$branch" != "latest" ]; then
    git checkout "$branch"
  fi
fi

printf 'Cloned %s to %s\n' "$repositoryUrl" "$destinationFolder"
