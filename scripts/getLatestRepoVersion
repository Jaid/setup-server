#!/usr/bin/env bash
set -o errexit

# Based on: https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c#gistcomment-2855619

latestTag=$(curl -sI https://github.com/$1/releases/latest | grep -iE "^Location:")
cleanedTag=$(echo "${latestTag##*/}" | tr -d '\r\n')
echo $cleanedTag
