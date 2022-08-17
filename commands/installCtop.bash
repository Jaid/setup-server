#!/usr/bin/env bash
set -o errexit

if [ -x "$(command -v ctop)" ]; then
  printf 'Command ctop already available\n'
  exit 0
fi

echo "deb http://packages.azlux.fr/debian/ buster main" | sudo tee /etc/apt/sources.list.d/azlux.list
wget -qO - https://azlux.fr/repo.gpg.key | sudo apt-key add -
aptGet update
aptGet install docker-ctop
