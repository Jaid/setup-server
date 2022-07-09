#!/usr/bin/env bash
set -e
set -o errexit

aptGet update
aptGet ncdu nethogs htop nano aria2 zip unzip exa bonnie++
