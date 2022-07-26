#!/usr/bin/env bash
set -o errexit

downloadFile=/etc/systemd/system/$1.service
downloadFile https://raw.githubusercontent.com/Jaid/setup-server/master/services/$1.service $downloadFile

timerStatusCode=$(curl --head https://raw.githubusercontent.com/Jaid/setup-server/master/timers/$1.timer --write-out "%{http_code}\n" --output /dev/null --silent)
if [ $timerStatusCode -eq 200 ]; then
  echo "Found $1.timer"
  timerDownloadFile=/etc/systemd/system/$1.timer
  downloadFile https://raw.githubusercontent.com/Jaid/setup-server/master/timers/$1.timer $timerDownloadFile
  sudo systemctl daemon-reload
  sudo systemctl enable --now $1.timer
else
  sudo systemctl daemon-reload
  sudo systemctl enable $1.service
  sudo service $1 restart
fi

echo Added and started $downloadFile
