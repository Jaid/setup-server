#!/bin/bash
set -o errexit -o pipefail

function hasCommand {
  commandPath=$(command -v "$1" || true)
  if [[ -z $commandPath ]]; then
    return 1
  fi
}

userTempFolder=${userTempFolder:-$HOME/temp}

source "$userTempFolder/config.bash"
export githubToken && export installCoolTools && export installGh && export installCargo && export installSd && export installJyt && export installLfs && export installRustScan && export installExa && export installRg && export installFd && export installGrc && export installDocker && export installZsh && export downloadAuthorizedKeys && export downloadBashrc && export downloadPath && export downloadEnv && export downloadSecrets && export downloadHtoprc && export downloadGitconfig && export downloadLocaleGen && export downloadDockerConfig && export userTempFolder && export userBinFolder && export foreignReposFolder

if [[ -z $githubToken ]]; then
  printf >&2 'Error: $githubToken not set\n'
  exit 1
fi

if [[ $githubToken =~ 000000000000000000000000000000000000 ]]; then
  printf >&2 'Error: $githubToken not changed\n'
  exit 1
fi

GITHUB_TOKEN=$githubToken
export GITHUB_TOKEN

mkdir --parents "$HOME/.cache"
mkdir --parents "$HOME/.config"
mkdir --parents "$userBinFolder"
mkdir --parents "$foreignReposFolder"

PATH=$PATH:$foreignReposFolder/scripts/bin:$HOME/.cargo/bin
export PATH

mkdir --parents "$foreignReposFolder"
if [[ -d $foreignReposFolder/scripts ]]; then
  rm -rf "$foreignReposFolder/scripts"
fi
if [[ -d $foreignReposFolder/setup-server ]]; then
  rm -rf "$foreignReposFolder/setup-server"
fi
curl --location --retry 3 --fail --silent --show-error --header 'Cache-Control: no-cache' --header "Authorization: Bearer $GITHUB_TOKEN" https://raw.githubusercontent.com/Jaid/scripts/dist/bin/downloadJaidScripts --output "$userBinFolder/downloadJaidScripts"
chmod +x "$userBinFolder"/*
bash -o xtrace "$userBinFolder/downloadJaidScripts"
fixTimezone
user=${USER:-$(whoami)}
if [[ -d /etc/sudoers.d ]] && [[ ! -f /etc/sudoers.d/$user ]]; then
  disableSudoPassword
fi
aptUpgrade
if [[ $installCoolTools = 1 ]]; then
  installCoolTools
fi
if [[ $installGh = 1 ]]; then
  if ! hasCommand gh; then
    installGh
  fi
fi
if [[ $installCargo = 1 ]]; then
  if ! hasCommand cargo; then
    installCargo
  fi
  if [[ $installSd = 1 ]]; then
    if ! hasCommand sd; then
      installSd
    fi
  fi
  if [[ $installJyt = 1 ]]; then
    if ! hasCommand jyt; then
      installJyt
    fi
  fi
  if [[ $installLfs = 1 ]]; then
    if ! hasCommand lfs; then
      installLfs
    fi
  fi
  if [[ $installRustScan = 1 ]]; then
    if ! hasCommand rustscan; then
      installRustscan
    fi
  fi
  if [[ $installExa = 1 ]]; then
    if ! hasCommand exa; then
      installExa
    fi
  fi
  if [[ $installRg = 1 ]]; then
    if ! hasCommand rg; then
      installRipgrep
    fi
  fi
  if [[ $installFd = 1 ]]; then
    if ! hasCommand fd; then
      installFd
    fi
  fi
fi
if [[ $downloadAuthorizedKeys = 1 ]]; then
  if [[ ! -f .ssh/authorized_keys ]]; then
    installGist ac460d2881bd2fef2ad69d9bc41ce20c # .ssh/authorized_keys
  fi
fi
if [[ $downloadBashrc = 1 ]]; then
  installGist 8e6f2105498f7f2bcff9822f38832c67 # .bashrc
fi
if [[ $downloadPath = 1 ]]; then
  installGist ce1dff0c5af35b4794dda93705f59742 # .path
fi
if [[ $downloadEnv = 1 ]]; then
  if [[ ! -f $HOME/.env ]]; then
    installGist e68ff74b342ffbf708620b37a617eb1d # .env
  fi
fi
if [[ $downloadSecrets = 1 ]]; then
  if [[ ! -f $HOME/.secrets ]]; then
    installGist 51021323256c14442c03eacdd3c56c3c # .secrets
    sed --in-place "s|ghp_000000000000000000000000000000000000|$GITHUB_TOKEN|g" ~/.secrets
  fi
fi
source "$HOME/.bashrc"
if [[ $downloadHtoprc = 1 ]]; then
  installGist d519aff77c198b0c452ba792358b6545 # htoprc
fi
if [[ $downloadGitconfig = 1 ]]; then
  installGist b81a839a438693a86718d3bb6347a9e4 # .gitconfig
fi
if [[ $downloadLocaleGen = 1 ]]; then
  installGist eac9757fdb899067a64f5880524823d9 # locale.gen
fi
setupLanguage
if [[ $installGrc = 1 ]]; then
  if ! hasCommand grc; then
    installGrc
  fi
fi
if [[ $installDocker = 1 ]]; then
  if ! hasCommand docker; then
    installDocker
  fi
  if [[ $downloadDockerConfig = 1 ]]; then
    installGist 3d590adcd183762ad7edffa5eff82c26 # /etc/docker/daemon.json
  fi
fi
if [[ $installZsh = 1 ]]; then
  if ! hasCommand zsh; then
    installZsh
  fi
fi
cleanHome
