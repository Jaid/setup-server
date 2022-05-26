#!/usr/bin/env bash
set -e
set -o errexit

aptGet install httpie
enableZshPlugin httpie
