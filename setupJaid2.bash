#!/usr/bin/env bash
set -e
set -o errexit

# This script is split into two files (setupJaid.bash, setupJaid2.bash), because I need a logout after installing Docker, doesn't work otherwise

installCaddy
installNetdata
installGithubReleaseWriter

rm ~/.bashrc
rm ~/.bash_logout
rm ~/.profile
rm ~/setup.bash
rm ~/.cloud-locale-test.skip
