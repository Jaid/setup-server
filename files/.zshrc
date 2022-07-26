#!/usr/bin/env zsh

test -f ~/.env && source "$_"
test -f ~/.secrets && source "$_"

path+=("$userBinFolder")
path+=("$otherReposFolder/scripts/scripts")
path+=(/usr/sbin)
export PATH

export ZSH="$otherReposFolder/ohmyzsh"
export ZSH_THEME=agnoster

interactiveTools=(
  ssh
  nano
  htop
  ctop
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

alias l='exa --long --all --group-directories-first --icons'
alias fd='fd --hidden'
