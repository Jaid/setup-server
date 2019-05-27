#!/usr/bin/env bash
set -e
set -o errexit

curl --fail --silent --header 'Cache-Control: no-cache' --location --retry 3 "$1" --output "$2"
sudo chown $(whoami) "$2"
