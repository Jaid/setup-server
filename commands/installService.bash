#!/usr/bin/env bash
set -e
set -o errexit

downloadFile=/etc/systemd/system/$1.service
downloadFile https://raw.githubusercontent.com/Jaid/setup-server/master/services/$1.service $downloadFile
sudo systemctl daemon-reload
sudo systemctl enable $1.service
sudo service $1 restart

timerStatusCode==$(curl --head https://raw.githubusercontent.com/Jaid/setup-server/master/timers/$1.timer --write-out "%{http_code}" --output /dev/null --silent)
if [ $timerStatusCode -ne "404" ]; then
  echo "Found $1.timer"
fi

echo Added and started $downloadFile
