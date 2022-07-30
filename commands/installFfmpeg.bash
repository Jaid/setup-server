#!/usr/bin/env bash
set -o errexit

: "${otherReposFolder:="$HOME/src"}"
: "${userBinFolder:="$HOME/bin"}"

buildFolder="$otherReposFolder/ffmpeg-build"
mkdir --parents "$buildFolder"

gitClone mstorsjo/fdk-aac
cd "$otherReposFolder/fdk-aac"
./autogen.sh
./configure --prefix="$buildFolder"
make
make install

# gitClone videolan/x265
# cd $otherReposFolder/x265/build/linux
# cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$otherReposFolder/ffmpeg-build" -DENABLE_SHARED=off ../../source
# make
# make install

# gitClone FFmpeg/FFmpeg latest $otherReposFolder/ffmpeg
# cd $_
# PKG_CONFIG_PATH="$otherReposFolder/ffmpeg-build/lib/pkgconfig" ./configure --prefix=$otherReposFolder --bindir="$USER_BIN_DIR" --pkg-config-flags="--static" --extra-cflags="-march=native -I$otherReposFolder/ffmpeg-build/include" --extra-ldflags="-L$otherReposFolder/ffmpeg-build/lib" --extra-libs="-lpthread -lm" --enable-hardcoded-tables --enable-gpl --enable-libass --enable-libfreetype --enable-libmp3lame --enable-libopus --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265 --enable-nonfree
# make
# make install
