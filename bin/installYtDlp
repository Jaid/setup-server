#!/usr/bin/env bash
set -o errexit

: "${userBinFolder:="$HOME/bin"}"
outputFile="$userBinFolder/yt-dlp"

downloadFile "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp" "$outputFile"
chmod +x "$outputFile"
