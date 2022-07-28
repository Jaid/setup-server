#!/usr/bin/env bash
set -o errexit

curl -fsSL https://my-netdata.io/kickstart.sh -o get-netdata.sh
bash get-netdata.sh
rm get-netdata.sh
