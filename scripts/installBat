#!/usr/bin/env bash
set -o errexit

batVersion="0.21.0"

SRC_DIR=~/src
mkdir --parents $SRC_DIR/bat
cd $_
downloadFile "https://github.com/sharkdp/bat/releases/download/v$batVersion/bat_${batVersion}_amd64.deb" release.deb
sudo dpkg -i release.deb
cd
rm -rf $SRC_DIR/bat
