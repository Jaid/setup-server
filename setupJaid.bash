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
