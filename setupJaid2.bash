#!/usr/bin/env bash
set -e
set -o errexit

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
