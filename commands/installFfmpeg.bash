#!/usr/bin/env bash
set -o errexit

: "${otherReposFolder:="$HOME/src"}"
: "${userBinFolder:="$HOME/bin"}"
: "${nasmVersion:=2.15.05}"
: "${vmafVersion:=2.3.1}"
: "${includeNasm:=1}"
: "${includeAac:=1}"
: "${includeOpus:=1}"
: "${includeAomav1:=1}"
: "${includeSvtav1:=1}"
: "${includeX264:=1}"
: "${includeX265:=1}"
: "${includeVpx:=1}"
: "${includeVmaf:=1}"

requireAptPackages autoconf automake build-essential cmake libass-dev libfreetype6-dev libmp3lame-dev libtool libvorbis-dev meson ninja-build pkg-config texinfo wget yasm zlib1g-dev libunistring-dev libaribb24-dev

buildFolder="$HOME/.cache/ffmpegBuild"
nonGitSourcesFolder="$buildFolder/src"
tempBinFolder="$buildFolder/bin"
mkdir --parents "$nonGitSourcesFolder"

PATH="$tempBinFolder:$PATH"

makeflags=(
  # Tailor for server usage
  --disable-ffplay
  --disable-doc
  --disable-htmlpages
  --disable-manpages
  --disable-podpages
  --disable-txtpages
  --disable-debug
  --disable-sndio
  --disable-network
  --enable-static

  # Select encoders
  --disable-encoders
  --enable-encoder=ass

  # Select muxers
  --disable-muxers
  --enable-muxer=webm

  # Select filters
  --disable-filters
  --enable-filter=scale
  --enable-filter=aresample

  # Optimization
  --enable-hardcoded-tables
  --enable-lto

  # Features
  --enable-libass
  --enable-libfreetype
  --enable-libmp3lame
  --enable-libvorbis
  --enable-libaribb24

  # Licenses
  --enable-nonfree
  --enable-version3
  --enable-gpl
)

# Based on NASM section from https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu

if [ "$includeNasm" -gt 0 ]; then
  cd "$nonGitSourcesFolder"
  curl --fail --location https://www.nasm.us/pub/nasm/releasebuilds/$nasmVersion/nasm-$nasmVersion.tar.bz2 --output nasm.tar.bz2
  tar xjvf nasm.tar.bz2
  rm nasm.tar.bz2
  cd nasm-$nasmVersion
  ./autogen.sh
  ./configure --prefix="$buildFolder" --bindir="$tempBinFolder"
  make
  make install
fi

# Based on libfdk-aac section from https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu

if [ "$includeAac" -gt 0 ]; then
  makeflags+=(--enable-libfdk-aac)
  makeflags+=(--enable-encoder=libfdk_aac)
  gitClone mstorsjo/fdk-aac
  cd "$otherReposFolder/fdk-aac"
  ./autogen.sh
  ./configure --prefix="$buildFolder" --disable-shared
  make
  make install
fi

# Based on libopus section from https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu

if [ "$includeOpus" -gt 0 ]; then
  makeflags+=(--enable-libopus)
  makeflags+=(--enable-encoder=libopus)
  gitClone xiph/opus
  cd "$otherReposFolder/opus"
  ./autogen.sh
  ./configure --prefix="$buildFolder" --disable-shared
  make
  make install
fi

# Based on https://www.iiwnz.com/build-ffmpeg-av1-svt

if [ "$includeAomav1" -gt 0 ]; then
  makeflags+=(--enable-libaom)
  makeflags+=(--enable-encoder=libaom-av1)
  gitClone jbeich/aom # Mirror of https://aomedia.googlesource.com/aom
  cd "$otherReposFolder/aom"
  mkdir --parents build
  cd build
  cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$buildFolder" -DENABLE_SHARED=off -DENABLE_NASM=on ..
  make
  make install
fi

# Based on https://www.iiwnz.com/build-ffmpeg-av1-svt

if [ "$includeSvtav1" -gt 0 ]; then
  makeflags+=(--enable-libsvtav1)
  makeflags+=(--enable-encoder=libsvtav1)
  gitClone AOMediaCodec/SVT-AV1
  cd "$otherReposFolder/SVT-AV1"
  mkdir --parents build
  cd build
  cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$buildFolder" -DCMAKE_BUILD_TYPE=Release -DBUILD_DEC=OFF -DBUILD_SHARED_LIBS=OFF ..
  make
  make install
fi

# Based on ?

if [ "$includeX264" -gt 0 ]; then
  makeflags+=(--enable-libx264)
  gitClone mirror/x264
  cd $otherReposFolder/x264
  ./configure --enable-static --prefix="$buildFolder"
  make
  make install
fi

if [ "$includeX265" -gt 0 ]; then
  makeflags+=(--enable-libx265)
  gitClone videolan/x265
  cd $otherReposFolder/x265/build/linux
  cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$buildFolder" -DENABLE_SHARED=off ../../source
  make
  make install
fi

if [ "$includeVpx" -gt 0 ]; then
  makeflags+=(--enable-libvpx)
  gitClone webmproject/libvpx
  cd "$otherReposFolder/libvpx"
  ./configure --prefix="$buildFolder" --enable-static --disable-shared --disable-docs --disable-tools --disable-unit-tests --disable-examples
  make
  make install
fi

# Based on libvmaf section from https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu

if [ "$includeVmaf" -gt 0 ]; then
  makeflags+=(--enable-libvmaf)
  cd "$nonGitSourcesFolder"
  curl --location --fail https://github.com/Netflix/vmaf/archive/v$vmafVersion.tar.gz --output vmaf.tar.gz
  tar xvf vmaf.tar.gz
  rm vmaf.tar.gz
  mkdir --parents vmaf-$vmafVersion/libvmaf/build
  cd vmaf-$vmafVersion/libvmaf/build
  meson setup -Denable_tests=false -Denable_docs=false --buildtype=release --default-library=static .. --prefix "$buildFolder" --bindir="$tempBinFolder" --libdir="$buildFolder/lib"
  ninja
  ninja install
fi

set -x
gitClone FFmpeg/FFmpeg
cd "$otherReposFolder/FFmpeg"
PKG_CONFIG_PATH="$buildFolder/lib/pkgconfig" ./configure --prefix="$otherReposFolder" --bindir="$tempBinFolder" --pkg-config-flags="--static" --extra-cflags="-march=native -I$buildFolder/include" --extra-libs="-lpthread -lm" --ld=g++ --extra-ldflags="-L$buildFolder/lib" "${makeflags[@]}"
make
make install

cp --force "$tempBinFolder/ffmpeg" "$userBinFolder"
du -hsb "$userBinFolder/ffmpeg"

cp --force "$tempBinFolder/ffprobe" "$userBinFolder"
du -hsb "$userBinFolder/ffprobe"
