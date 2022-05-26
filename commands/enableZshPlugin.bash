#!/usr/bin/env bash
set -e
set -o errexit

ZSH_PLUGINS=$ZSH/custom/plugins

sed -z "s/plugins=(\n/plugins=(\n  $1\n/" ~/.zshrc

echo "Enabled zsh plugin: $1"
