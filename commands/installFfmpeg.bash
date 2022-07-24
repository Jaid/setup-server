#!/usr/bin/env bash
set -o errexit

SRC_DIR=~/src
USER_BIN_DIR=~/bin

mkdir --parents $SRC_DIR/ffmpeg-build

gitClone mstorsjo/fdk-aac
cd $SRC_DIR/fdk-aac
./autogen.sh
./configure --prefix="$SRC_DIR/ffmpeg-build"
make
make install

gitClone videolan/x265
cd $SRC_DIR/x265/build/linux
cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$SRC_DIR/ffmpeg-build" -DENABLE_SHARED=off ../../source
make
make install

gitClone FFmpeg/FFmpeg latest $SRC_DIR/ffmpeg
cd $_
PKG_CONFIG_PATH="$SRC_DIR/ffmpeg-build/lib/pkgconfig" ./configure --prefix=$SRC_DIR --bindir="$USER_BIN_DIR" --pkg-config-flags="--static" --extra-cflags="-march=native -I$SRC_DIR/ffmpeg-build/include" --extra-ldflags="-L$SRC_DIR/ffmpeg-build/lib" --extra-libs="-lpthread -lm" --enable-hardcoded-tables --enable-gpl --enable-libass --enable-libfreetype --enable-libmp3lame --enable-libopus --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265 --enable-nonfree
make
make install
