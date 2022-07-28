#!/usr/bin/env bash
set -o errexit

targetUser=jaid

bashFile=/home/$targetUser/setup.bash
downloadFile "https://raw.githubusercontent.com/Jaid/setup-server/master/setupJaid.bash" $bashFile
chown --recursive $targetUser:$targetUser /home/$targetUser
chmod +x $bashFile
bash -c "sudo --non-interactive --set-home --user=$targetUser DEBIAN_FRONTEND=noninteractive PS4='[:\$LINENO] ' bash -e -x $bashFile >> /home/$targetUser/setup.log 2>&1"

bashFile=/home/$targetUser/setup2.bash
downloadFile "https://raw.githubusercontent.com/Jaid/setup-server/master/setupJaid2.bash" $bashFile
chown --recursive $targetUser:$targetUser /home/$targetUser
chmod +x $bashFile
bash -c "sudo --non-interactive --set-home --user=$targetUser DEBIAN_FRONTEND=noninteractive PS4='[:\$LINENO] ' bash -e -x $bashFile >> /home/$targetUser/setup.log 2>&1"
