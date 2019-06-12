#!/usr/bin/env bash
set -e
set -o errexit

latestTag=$(curl -sI https://github.com/$1/releases/latest | grep -iE "^Location:")
cleanedTag=$(echo "${latestTag##*/}" | tr -d '\r\n')
echo $cleanedTag
