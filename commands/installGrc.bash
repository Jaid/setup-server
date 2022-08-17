#!/usr/bin/env bash
set -o errexit

: "${otherReposFolder:="$HOME/src"}"

if [ -x "$(command -v grc)" ]; then
  echo 'Command grc already available'
  exit 0
fi

requireAptPackages python3 debhelper dh-python

gitClone garabik/grc
cd "$otherReposFolder/grc"

dpkg-buildpackage -b -rfakeroot
sudo dpkg --install "$otherReposFolder"/*.deb
rm "$otherReposFolder"/grc_*

#!/usr/bin/env bash
set -o errexit
