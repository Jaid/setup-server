#!/usr/bin/env bash
set -o errexit

declare -a missingAptPackages=()
declare -a requiredAptPackages=(install ncdu nethogs htop aria2 zip unzip exa bonnie++ fd-find)
for requiredAptPackage in "${requiredAptPackages[@]}"; do
  if [ ! "$(dpkg -l "$requiredAptPackage")" ]; then
    missingAptPackages+=("$requiredAptPackage")
  fi
done
if [ ${#missingAptPackages[@]} -gt 0 ]; then
  printf 'Installing apt packages: %s' "${missingAptPackages[@]}"
  aptGet update
  aptGet install "${missingAptPackages[@]}"
fi
