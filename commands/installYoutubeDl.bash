#!/usr/bin/env bash
set -e
set -o errexit

tag=$(getLatestRepoVersion ytdl-org/youtube-dl | tr -d '\r\n')
downloadFile=/usr/local/bin/youtube-dl
sudo downloadFile "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp" $downloadFile
sudo chmod +x $downloadFile
