#!/usr/bin/env bash
set -e
set -o errexit

# This script is split into two files (setupJaid.bash, setupJaid2.bash), because I need a logout after installing Docker, doesn't work otherwise

downloadJaidScript installCaddy && $_
downloadJaidScript installNetdata && $_
downloadJaidScript installGithubReleaseWriter && $_
downloadJaidScript installHttpie && $_
downloadJaidScript installYtDlp && $_
downloadJaidScript installBat && $_
# downloadJaidScript installFfmpeg && $_

rm ~/.bashrc
rm ~/.bash_logout
rm ~/.profile
rm ~/setup.bash
rm ~/.cloud-locale-test.skip

# Nice tools

aptGet install ncdu nethogs htop nano aria2 zip unzip
