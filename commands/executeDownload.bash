#!/usr/bin/env bash

mkdir -p ~/.cache/executeDownload
hash=$(echo -n "$1" | md5sum | awk '{print $1}')
downloadPath=~/.cache/executeDownload/$hash.bash
downloadFile "$1" "$downloadPath"
chmod +x "$downloadPath"
"$downloadPath"
