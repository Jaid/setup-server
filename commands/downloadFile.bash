#!/usr/bin/env bash

curl --fail --silent --header 'Cache-Control: no-cache' --location --retry 3 "$1" | tee "$2"
