#!/usr/bin/env zsh

if [ -f ~/.env ]; then
  source ~/.env
fi

if [ -f ~/.secrets ]; then
  source ~/.secrets
fi

if [ -d "$userBinFolder" ]; then
  path+=("$userBinFolder")
fi

if [ -d "$otherReposFolder" ]; then
  path+=("$otherReposFolder/scripts/bin")
  path+=("$otherReposFolder/setup-server/bin")
fi

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

if [ -x "$(command -v docker)" ]; then
  zstyle ':completion:*:*:docker:*' option-stacking yes
  zstyle ':completion:*:*:docker-*:*' option-stacking yes
fi

if [ -d "$ZSH/custom/plugins/zsh-autocomplete" ]; then
  zstyle ':autocomplete:*' min-delay 0.5
  zstyle ':autocomplete:*' min-input 1
  zstyle ':autocomplete:*' recent-dirs no
  zstyle ':autocomplete:history-search:*' list-lines 5
fi

source "$ZSH/oh-my-zsh.sh"

if [ -x "$(command -v exa)" ]; then
  alias l='exa --long --all --group-directories-first --icons'
else
  alias l="ls --all --color=always --group-directories-first --literal --format=long"
fi

if [ -x "$(command -v fd)" ]; then
  alias fd='fd --hidden'
fi

if [ -x "$(command -v yt-dlp)" ]; then
  alias dlp='yt-dlp'
fi

if [ -x "$(command -v ffmpeg)" ]; then
  alias ffmpeg='ffmpeg -hide_banner'
fi

if [ -x "$(command -v ffprobe)" ]; then
  alias ffprobe='ffprobe -hide_banner'
fi

if [ -x "$(command -v ncu)" ]; then
  alias 'up?'='ncu'
  alias 'up??'='ncu --target greatest'
  alias upf='upFilter'
fi

if [ -x "$(command -v docker)" ]; then
  alias d='docker'
  alias dc='docker compose'
fi
