#!/usr/bin/env bash
set -o errexit

requireAptPackages zsh

: "${otherReposFolder:="$HOME/src"}"
: "${userBinFolder:="$HOME/bin"}"

export ZSH=$otherReposFolder/ohmyzsh
export ZSH_PLUGINS=$ZSH/custom/plugins
gitClone ohmyzsh/ohmyzsh

chmod --recursive go-w "$ZSH"

downloadJaidFile .zshrc ~/.zshrc
downloadJaidFile .env ~/.env
downloadJaidFile .secrets ~/.secrets

downloadZshPlugin zsh-autosuggestions zsh-users/zsh-autosuggestions
downloadZshPlugin zsh-syntax-highlighting zsh-users/zsh-syntax-highlighting
downloadZshPlugin zsh-autocomplete marlonrichert/zsh-autocomplete
downloadZshPlugin you-should-use MichaelAquilina/zsh-you-should-use
enableZshPlugin command-not-found
downloadZshPlugin command-time popstas/zsh-command-time

user=${USER:-$(whoami)}
sudo usermod --shell /bin/zsh "$user"
