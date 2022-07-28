#!/usr/bin/env bash
set -o errexit
set +o monitor
shopt -s lastpipe

: "${otherReposFolder:="$HOME/src"}"
: "${userBinFolder:="$HOME/bin"}"

inputFolder="$repoFolder/commands"

mkdir --parents "$userBinFolder"
mkdir --parents "$otherReposFolder"

declare -a scriptRepos=(
  setup-server
  scripts
)
for scriptRepo in "${scriptRepos[@]}"; do
  printf 'Repo: “%s”\n' "$scriptRepo"
  repoFolder="$otherReposFolder/$scriptRepo"
  if [ ! -d "$repoFolder" ]; then
    printf "%s does not exist, cloning\n" "$repoFolder"
    git clone https://github.com/Jaid/setup-server.git "$repoFolder"
    git checkout dist
  else
    git -C "$repoFolder" pull --ff-only --quiet
  fi
  repoBinFolder="$repoFolder/bin"
  find "$repoBinFolder" -type f -printf '%f\0' | while read -r -d $'\0' file; do
    fullPath="$repoBinFolder/$file"
  done
  if [ -x "$file" ]; then
    :
  fi
done

# declare -i allCount=0
# declare -i changedCount=0

# find "$inputFolder" -type f -printf '%f\n' | while read -r file; do
#   scriptName=$(printf %s "$file" | sed 's|\.\w\+$||')
#   inputFile="$inputFolder/$file"
#   outputFile="$userBinFolder/$scriptName"
#   if [ -f "$outputFile" ]; then
#     inputMd5=$(md5sum "$inputFile" | cut --fields 1 --delimiter " ")
#     outputMd5=$(md5sum "$outputFile" | cut --fields 1 --delimiter " ")
#     if [ "$inputMd5" != "$outputMd5" ]; then
#       echo "Updating: $scriptName"
#       cp --no-preserve=mode,ownership "$inputFile" "$outputFile"
#       ((changedCount++)) || true
#     fi
#   else
#     echo "Adding: $scriptName"
#     cp "$inputFile" "$outputFile"
#     chmod +x "$inputFile"
#     ((changedCount++)) || true
#   fi
#   ((allCount++)) || true
# done

printf 'Updated %s/%s scripts\n' "$changedCount" "$allCount"
