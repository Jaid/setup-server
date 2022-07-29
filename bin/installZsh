#!/usr/bin/env bash
set -o errexit

requireAptPackages zsh

: "${otherReposFolder:="$HOME/src"}"
: "${userBinFolder:="$HOME/bin"}"

export ZSH=$otherReposFolder/ohmyzsh
export ZSH_PLUGINS=$ZSH/custom/plugins
gitClone ohmyzsh/ohmyzsh

chmod --recursive go-w "$ZSH"

installGist 1b2dfe2cd4dca4e031a892e70a317ae7
installGist e68ff74b342ffbf708620b37a617eb1d
installGist 51021323256c14442c03eacdd3c56c3c

if [ -f ~/.bashrc ]; then
  mv ~/.bashrc ~/.bashrc_old
fi
if [ -f ~/.bash_profile ]; then
  mv ~/.bash_profile ~/.bash_profile_old
fi
if [ -f ~/.profile ]; then
  mv ~/.profile ~/.profile
fi
installGist 8e6f2105498f7f2bcff9822f38832c67

downloadZshPlugin zsh-autosuggestions zsh-users/zsh-autosuggestions
downloadZshPlugin zsh-syntax-highlighting zsh-users/zsh-syntax-highlighting
downloadZshPlugin zsh-autocomplete marlonrichert/zsh-autocomplete
downloadZshPlugin you-should-use MichaelAquilina/zsh-you-should-use
enableZshPlugin command-not-found
downloadZshPlugin command-time popstas/zsh-command-time

user=${USER:-$(whoami)}
sudo usermod --shell /bin/zsh "$user"
