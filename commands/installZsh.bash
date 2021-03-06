#!/usr/bin/env bash
set -e
set -o errexit

SRC_DIR=~/src
USER_BIN_DIR=~/bin

ZSH=$SRC_DIR/oh-my-zsh
ZSH_PLUGINS=$ZSH/custom/plugins
gitClone robbyrussell/oh-my-zsh
gitClone zsh-users/zsh-syntax-highlighting latest $ZSH_PLUGINS/zsh-syntax-highlighting
gitClone zsh-users/zsh-autosuggestions latest $ZSH_PLUGINS/zsh-autosuggestions
gitClone MichaelAquilina/zsh-you-should-use latest $ZSH_PLUGINS/you-should-use

mkdir --parents $SRC_DIR/zsh-yarn-autocompletions
cd $_
downloadFile "https://github.com/g-plane/zsh-yarn-autocompletions/releases/download/v1.2.0/yarn-autocompletions_v1.2.0_linux.zip" release.zip
unzip -o release.zip
./install.sh $ZSH_PLUGINS

chmod --recursive go-w $ZSH

echo "
    export ZSH=$ZSH
    export ZSH_THEME=agnoster
    export LANG=en_US.UTF-8
    export PATH=\$PATH:$HOME/.yarn/bin:$USER_BIN_DIR
    export MAKEFLAGS=-j$(nproc)
    export NODE_OPTIONS=--max_old_space_size=8000
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
    plugins=(
      zsh-syntax-highlighting
      zsh-autosuggestions
      command-not-found
      you-should-use
      extract
      git
      yarn-autocompletions
    )
    source $ZSH/oh-my-zsh.sh
    setopt histreduceblanks
    setopt histignorealldups
    setopt globdots
    setopt extendedglob
    setopt listpacked
    setopt rmstarsilent" | dd of=~/.zshrc
