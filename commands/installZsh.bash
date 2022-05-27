#!/usr/bin/env bash
set -e
set -o errexit

downloadJaidScript enableZshPlugin
downloadJaidScript downloadZshPlugin

aptGet install zsh

SRC_DIR=~/src
USER_BIN_DIR=~/bin

ZSH=$SRC_DIR/oh-my-zsh
ZSH_PLUGINS=$ZSH/custom/plugins
gitClone robbyrussell/oh-my-zsh

chmod --recursive go-w $ZSH

touch ~/.secrets.sh

echo "export PATH=\$PATH:$USER_BIN_DIR

export ZSH=$ZSH
export ZSH_THEME=agnoster

export LANG=en_US.UTF-8
export MAKEFLAGS=-j$(nproc)
export NODE_OPTIONS=--max_old_space_size=8000

CASE_SENSITIVE=true
HIST_STAMPS=dd.mm.yyyy

export LANG=en_US.UTF-8
export PERSONAL_LOCALE=de_DE.UTF-8
export LANGUAGE=\$LANG
export LC_PAPER=\$PERSONAL_LOCALE
export LC_ADDRESS=\$PERSONAL_LOCALE
export LC_MONETARY=\$PERSONAL_LOCALE
export LC_NUMERIC=\$LANG
export LC_TELEPHONE=\$PERSONAL_LOCALE
export LC_IDENTIFICATION=\$LANG
export LC_MEASUREMENT=\$PERSONAL_LOCALE
export LC_CTYPE=\$PERSONAL_LOCALE
export LC_NAME=\$PERSONAL_LOCALE
export LC_MESSAGES=\$LANG
export LC_TIME=\$PERSONAL_LOCALE

export EDITOR=nano

interactiveTools=(
  ssh
  nano
  htop
  ncdu
  nethogs
)

ZSH_COMMAND_TIME_MIN_SECONDS=15
ZSH_COMMAND_TIME_EXCLUDE=\$interactiveTools

zbell_ignore=\$interactiveTools

plugins=(
)

source $ZSH/oh-my-zsh.sh

setopt histreduceblanks
setopt histignorealldups
setopt globdots
setopt extendedglob
setopt listpacked
setopt rmstarsilent

test -f ~/.secrets && source $_
test -f ~/.secrets.sh && source $_
" | dd of=~/.zshrc

downloadZshPlugin zsh-autosuggestions zsh-users/zsh-autosuggestions
downloadZshPlugin zsh-syntax-highlighting zsh-users/zsh-syntax-highlighting
downloadZshPlugin you-should-use MichaelAquilina/zsh-you-should-use
enableZshPlugin command-not-found
enableZshPlugin extract
enableZshPlugin git
enableZshPlugin httpie
enableZshPlugin sudo
enableZshPlugin zbell
downloadZshPlugin command-time popstas/zsh-command-time
