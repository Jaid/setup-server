#!/usr/bin/env bash
set -o errexit

declare -a missingAptPackages=()
declare -a requiredAptPackages=(ncdu nethogs htop aria2 zip unzip exa)
for requiredAptPackage in "${requiredAptPackages[@]}"; do
  if [ ! "$(dpkg -l "$requiredAptPackage")" ]; then
    missingAptPackages+=("$requiredAptPackage")
  fi
done
if [ ${#missingAptPackages[@]} -gt 0 ]; then
  printf 'Installing apt packages: %s\n' "${missingAptPackages[*]}"
  aptGet update
  aptGet install ${missingAptPackages[@]}
fi
