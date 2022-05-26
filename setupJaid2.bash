#!/usr/bin/env bash
set -e
set -o errexit

# downloadJaidScript installCaddy && $_
downloadJaidScript installNetdata && $_
downloadJaidScript installGithubReleaseWriter && $_
downloadJaidScript installHttpie && $_
downloadJaidScript installYtDlp && $_
downloadJaidScript installBat && $_
downloadJaidScript installNode && $_
# downloadJaidScript installFfmpeg && $_

rm ~/.bashrc
rm ~/.bash_logout
rm ~/.profile
rm ~/setup.bash

# Nice tools

aptGet install ncdu nethogs htop nano aria2 zip unzip
