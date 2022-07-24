#!/usr/bin/env bash
set -o errexit

aptGet install httpie
enableZshPlugin httpie
