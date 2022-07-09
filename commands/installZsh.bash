#!/usr/bin/env bash
set -e
set -o errexit

downloadJaidScript enableZshPlugin
downloadJaidScript downloadZshPlugin

aptGet install zsh

SRC_DIR=~/src
USER_BIN_DIR=~/bin

mkdir --parents "$SRC_DIR"

ZSH=$SRC_DIR/ohmyzsh
ZSH_PLUGINS=$ZSH/custom/plugins
gitClone ohmyzsh/ohmyzsh

chmod --recursive go-w $ZSH

downloadJaidFile .zshrc ~/.zshrc
downloadJaidFile .env ~/.env
downloadJaidFile .secrets ~/.secrets

downloadZshPlugin zsh-autosuggestions zsh-users/zsh-autosuggestions
downloadZshPlugin zsh-syntax-highlighting zsh-users/zsh-syntax-highlighting
downloadZshPlugin zsh-autocomplete marlonrichert/zsh-autocomplete
downloadZshPlugin you-should-use MichaelAquilina/zsh-you-should-use
enableZshPlugin command-not-found
enableZshPlugin extract
enableZshPlugin git
enableZshPlugin zbell
docker-compose
docker
downloadZshPlugin command-time popstas/zsh-command-time
