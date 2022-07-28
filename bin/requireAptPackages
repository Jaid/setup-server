#!/usr/bin/env bash
set -o errexit

if [ $# -lt 1 ]; then
  printf >&2 '$(tput setaf 1)Arguments needed: %s
Arguments given:  %s$(tput sgr0)\n' 1 $#
  exit 1
fi

declare -a requiredAptPackages=()
for positionalArgument; do
  requiredAptPackages+=("$positionalArgument")
done

declare -a missingAptPackages=()
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
