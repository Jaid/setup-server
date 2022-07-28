#!/usr/bin/env bash
set -e
set -o errexit

mkdir -p ~/bin
mkdir -p ~/src

setupLanguage
installZsh
installNode
installDocker
