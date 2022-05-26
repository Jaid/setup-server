#!/usr/bin/env bash
set -e
set -o errexit

downloadFile=/usr/local/bin/yt-dlp
sudo downloadFile "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp" $downloadFile
sudo chmod +x $downloadFile
