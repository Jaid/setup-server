#!/usr/bin/env bash
set -e
set -o errexit

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm get-docker.sh
