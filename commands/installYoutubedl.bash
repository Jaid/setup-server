#!/usr/bin/env bash
set -e
set -o errexit

tag=$(latest-github-release --owner ytdl-org --repository youtube-dl --tag | tr -d '\r\n')
downloadFile=/usr/local/bin/youtube-dl
sudo downloadFile "https://github.com/ytdl-org/youtube-dl/releases/download/$tag/youtube-dl" $downloadFile
sudo chmod +x $downloadFile

initScript=/etc/init.d/updateYoutubeDl
echo -e "#\!/bin/sh\n/usr/local/bin/youtube-dl --update" | sudo dd of=$initScript
sudo chmod +x $initScript
