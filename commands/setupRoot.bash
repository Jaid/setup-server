#!/usr/bin/env bash
set -e
set -o errexit

downloadJaidScript downloadFile
downloadJaidScript executeDownload
downloadJaidScript setupUser
downloadJaidScript aptGet
downloadJaidScript gitClone
setupUser
curl -X POST https://maker.ifttt.com/trigger/done/with/key/cJqOfxLAqwHiV9dHIijbx0
shutdown -r now
