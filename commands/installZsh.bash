#!/usr/bin/env bash
set -e
set -o errexit

downloadJaidScript enableZshPlugin
downloadJaidScript downloadZshPlugin

aptGet install zsh

SRC_DIR=~/src
USER_BIN_DIR=~/bin

ZSH=$SRC_DIR/ohmyzsh
ZSH_PLUGINS=$ZSH/custom/plugins
gitClone ohmyzsh/ohmyzsh

chmod --recursive go-w $ZSH

downloadJaidFile .zshrc ~/.zshrc
downloadJaidFile .env ~/.env
downloadJaidFile .secrets ~/.secrets

downloadZshPlugin zsh-autosuggestions zsh-users/zsh-autosuggestions
downloadZshPlugin zsh-syntax-highlighting zsh-users/zsh-syntax-highlighting
downloadZshPlugin you-should-use MichaelAquilina/zsh-you-should-use
downloadZshPlugin zsh-autocomplete marlonrichert/zsh-autocomplete
enableZshPlugin command-not-found
enableZshPlugin extract
enableZshPlugin git
enableZshPlugin httpie
enableZshPlugin sudo
enableZshPlugin zbell
downloadZshPlugin command-time popstas/zsh-command-time
