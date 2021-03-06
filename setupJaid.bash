#!/usr/bin/env bash
set -e
set -o errexit

mkdir -p ~/bin
mkdir -p ~/src

downloadJaidScript setupLanguage && $_
downloadJaidScript installZsh && $_
downloadJaidScript installNode && $_
downloadJaidScript installBat && $_
downloadJaidScript installFfmpeg && $_
downloadJaidScript installJaidbot && $_
downloadJaidScript installYoutubeDl && $_

rm ~/.bashrc
rm ~/.bash_logout
rm ~/.profile
rm ~/setup.bash
