#!/usr/bin/env bash
set -o errexit

downloadJaidFile locale.gen /etc/locale.gen
sudo locale-gen --purge
