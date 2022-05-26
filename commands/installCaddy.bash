#!/usr/bin/env bash
set -e
set -o errexit

installCompose caddy

echo "cloudflareToken=
" | dd of=~/docker/caddy/.env
