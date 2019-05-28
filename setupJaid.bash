#!/usr/bin/env bash
set -e
set -o errexit

mkdir -p ~/bin
mkdir -p ~/src

downloadJaidScript setupLanguage && $_
downloadJaidScript installZsh && $_
downloadJaidScript installNode && $_ && source $HOME/src/nvm/nvm.sh
downloadJaidScript installBat && $_
downloadJaidScript installFfmpeg && $_
downloadJaidScript installJaidbot && $_ && jaidbot
downloadJaidScript installYoutubeDl && $_
