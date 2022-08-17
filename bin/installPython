#!/usr/bin/env bash
set -o errexit

if [ -x "$(command -v python3)" ]; then
  printf 'Command python3 already available\n'
  exit 0
fi

requireAptPackages python3 python3-pip

pip install PyYAML
