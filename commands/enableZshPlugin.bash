#!/usr/bin/env bash
set -o errexit

ZSH_PLUGINS=$ZSH/custom/plugins

sed --zero-terminated --in-place "s|plugins=(\n|plugins=(\n  $1\n|" ~/.zshrc

echo "Enabled zsh plugin: $1"
