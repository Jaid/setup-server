#!/usr/bin/env bash
set -e
set -o errexit

gitClone dylanaraps/neofetch
echo -e "\nbash ~/src/neofetch/neofetch" | tee -a ~/.zshrc
