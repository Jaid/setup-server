#!/usr/bin/env bash
set -e
set -o errexit

mkdir -p ~/bin
mkdir -p ~/src

downloadJaidScript setupLanguage && $_
downloadJaidScript installZsh && $_
source ~/.zshrc
downloadJaidScript installNode && $_
downloadJaidScript installBat && $_
