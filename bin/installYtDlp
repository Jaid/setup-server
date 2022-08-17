#!/usr/bin/env bash
set -o errexit

if [ -x "$(command -v yt-dlp)" ]; then
  printf 'Command yt-dlp already available\n'
fi

: "${userBinFolder:="$HOME/bin"}"
outputFile="$userBinFolder/yt-dlp"

downloadFile "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp" "$outputFile"
chmod +x "$outputFile"
