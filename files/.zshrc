#!/usr/bin/env zsh

path=(
  /e/Scripts
  /e/Binaries
  /p/Git/node-scripts/dist/bin
  /p/Git/node-scripts/dist/exe
  /p/Others/media-autobuild/local64/bin-global
  /p/Others/media-autobuild/local64/bin-video
  /p/Others/media-autobuild/local64/bin-audio
  $HOME/AppData/Local/Android/Sdk/platform-tools
  "${path[@]}"
  '/c/Program Files/Git/bin'
  '/c/Program Files/Docker/Docker/resources/bin'
  '/c/Program Files/Tesseract-OCR'
  /e/Portables/gmic-cli/3.1.2
  $HOME/AppData/Roaming/Python/Python38/Scripts
)
export PATH

test -f ~/.env && source $_
test -f ~/.secrets && source $_

export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME=agnoster-no-git

CASE_SENSITIVE=true
HIST_STAMPS=dd.mm.yyyy

export LANG=en_US.UTF-8
export MAKEFLAGS=-j16
# export PROMPT_COMMAND='history -a && (powershell -c "(New-Object Media.SoundPlayer \"S:/Archive/Sounds/Portal 2\ui\move.wav\").PlaySync();" &)'

export LANG=en_US.UTF-8
export PERSONAL_LOCALE=de_DE.UTF-8
export LANGUAGE=$LANG
export LC_PAPER=$PERSONAL_LOCALE
export LC_ADDRESS=$PERSONAL_LOCALE
export LC_MONETARY=$PERSONAL_LOCALE
export LC_NUMERIC=$LANG
export LC_TELEPHONE=$PERSONAL_LOCALE
export LC_IDENTIFICATION=$LANG
export LC_MEASUREMENT=$PERSONAL_LOCALE
export LC_CTYPE=$PERSONAL_LOCALE
export LC_NAME=$PERSONAL_LOCALE
export LC_MESSAGES=$LANG
export LC_TIME=$PERSONAL_LOCALE

# for https://github.com/peterbraden/node-opencv#specific-for-windows
export OPENCV_DIR=$(echo /e/Portables/opencv/*/build/x64/vc15)

# for https://github.com/justadudewhohacks/opencv4nodejs#how-to-install
export OPENCV4NODEJS_DISABLE_AUTOBUILD=1
export OPENCV_LIB_DIR=/e/Portables/opencv/4.6.0/build/x64/vc15/lib
export OPENCV_BIN_DIR=/e/Portables/opencv/4.6.0/build/x64/vc15/bin
export OPENCV_INCLUDE_DIR=/e/Portables/opencv/4.6.0/build/include/opencv2
export OPENCV_BUILD_ROOT="$HOME/.cache/opencv4nodejs"

export EDITOR=nano

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

ZSH_HIGHLIGHT_DIRS_BLACKLIST+=(//) # Disable all paths, it freezes too often

plugins=(
  jaid
  command-time
  docker-compose
  docker
  zbell
  git
  extract
  command-not-found
  you-should-use
  zsh-autocomplete
  zsh-syntax-highlighting
  zsh-autosuggestions
)

zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

zstyle ':autocomplete:*' min-delay 0.5
zstyle ':autocomplete:*' min-input 1
zstyle ':autocomplete:*' recent-dirs no
zstyle ':autocomplete:history-search:*' list-lines 5

source $ZSH/oh-my-zsh.sh

alias l="exa --long --all --group-directories-first --icons"
alias git="hub"
alias 'fd=fd --hidden'
