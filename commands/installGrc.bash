#!/usr/bin/env bash
set -o errexit

: "${otherReposFolder:="$HOME/src"}"

requireAptPackages python3 debhelper dh-python

gitClone garabik/grc
cd "$otherReposFolder/grc"

dpkg-buildpackage -b -rfakeroot
sudo dpkg --install "$otherReposFolder"/*.deb
rm "$otherReposFolder/"grc_*
