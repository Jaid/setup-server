#!/usr/bin/env bash

mkdir -p ~/src

cd $HOME # It's safer: https://stackoverflow.com/questions/9851644/git-pulling-depends-on-the-current-dir
if [[ $1 =~ .*:.* ]]; then
  REPO=$1
else
  REPO="https://github.com/$1"
fi
if [ $3 ]; then
  DESTINATION=$3
else
  NAME=${REPO##*/}
  DESTINATION=${SRC_DIR:-$HOME/src}/$NAME
fi
DESTINATION_PARENT=$(dirname $DESTINATION)
[ ! -d $DESTINATION_PARENT ] && mkdir --parents $DESTINATION_PARENT
if [ -d $DESTINATION ]; then
  cd $DESTINATION
  git pull || true # May not work, but it's not important, so we always return code 0.
else
  git clone $REPO $DESTINATION
  cd $_
fi
if [ $2 ]; then
  if [ "$2" = "release" ]; then
    git checkout $(git tag | tail -1)
  elif [ "$2" != "latest" ]; then
    git checkout $2
  fi
fi
echo Cloned $1
