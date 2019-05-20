#!/usr/bin/env bash
set -e
set -o errexit

sudo apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes --quiet "$@"
