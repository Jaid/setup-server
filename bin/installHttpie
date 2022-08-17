#!/usr/bin/env bash
set -o errexit

if [ -x "$(command -v httpie)" ]; then
  echo 'Command httpie already available'
  exit 0
fi

aptGet install httpie
enableZshPlugin httpie
