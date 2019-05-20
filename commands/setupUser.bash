#!/usr/bin/env bash
set -e
set -o errexit

targetUser=jaid
bashFile=/home/$targetUser/setup.bash
downloadFile "https://raw.githubusercontent.com/Jaid/setup-server/master/setupJaid.bash" $bashFile
#chown --recursive $targetUser:$targetUser /home/$targetUser Fails for some reason
chmod +x $bashFile
bash -c "sudo --non-interactive --set-home --user=$targetUser DEBIAN_FRONTEND=noninteractive zsh -e -x $bashFile > /home/$targetUser/setup.log 2>&1"
