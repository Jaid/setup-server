#!/usr/bin/env zsh

path+=(/home/pi/bin)
path+=(/usr/sbin)
export PATH

test -f ~/.env && source "$_"
test -f ~/.secrets && source "$_"

export ZSH="$HOME/src/ohmyzsh"
export ZSH_THEME=agnoster

interactiveTools=(
  ssh
  nano
  htop
  ncdu
  nethogs
)

ZSH_COMMAND_TIME_MIN_SECONDS=15
ZSH_COMMAND_TIME_EXCLUDE=$interactiveTools

DISABLE_MAGIC_FUNCTIONS=true

zbell_ignore=$interactiveTools

plugins=(
)

zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

zstyle ':autocomplete:*' min-delay 0.5
zstyle ':autocomplete:*' min-input 1
zstyle ':autocomplete:*' recent-dirs no
zstyle ':autocomplete:history-search:*' list-lines 5

source "$ZSH/oh-my-zsh.sh"

alias l="exa --long --all --group-directories-first --icons"
alias git="hub"
alias 'fd=fd --hidden'
