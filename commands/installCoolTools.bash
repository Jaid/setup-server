#!/usr/bin/env bash
set -e
set -o errexit

aptGet update
aptGet install ncdu nethogs htop aria2 zip unzip exa bonnie++ fd-find
