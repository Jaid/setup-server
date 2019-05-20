#!/bin/bash

user=jaid
bashFile=/home/$user/setup.bash
downloadFile "https://raw.githubusercontent.com/Jaid/setup-server/master/setupJaid.bash" $bashFile
chown $user $bashFile
chmod +x $bashFile
nohup bash -c "sudo --non-interactive --set-home --user=$user DEBIAN_FRONTEND=noninteractive PS4='[:\$LINENO] ' bash -e -x $bashFile > /home/$user/setup.log 2>&1"
