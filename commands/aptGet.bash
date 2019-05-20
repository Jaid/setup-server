#!/usr/bin/env bash

sudo apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes --quiet "$@"
