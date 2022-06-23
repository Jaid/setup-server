#!/usr/bin/env bash
set -e
set -o errexit

ZSH_PLUGINS=~/src/ohmyzsh/custom/plugins

if [ -z ${2+x} ]; then
  echo "Using native plugin $1"
else
  echo "Download zsh plugin: $2"
  gitClone $2 latest $ZSH_PLUGINS/$1
fi

enableZshPlugin $1
