#!/usr/bin/env bash
set -o errexit

downloadJaidScript enableZshPlugin
downloadJaidScript downloadZshPlugin

requireAptPackages zsh

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
downloadZshPlugin command-time popstas/zsh-command-time

sudo usermod --shell /bin/zsh "$USER"
