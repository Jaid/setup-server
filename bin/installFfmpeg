#!/usr/bin/env bash
set -o errexit

: "${buildFolder:="$HOME/.cache/ffmpegBuild"}"
: "${userBinFolder:="$HOME/bin"}"
: "${nasmVersion:=2.15.05}"
: "${vmafVersion:=2.3.1}"
: "${includeNasm:=1}"
: "${includeAac:=1}"
: "${includeOpus:=1}"
: "${includeDav1d:=1}"
: "${includeAomav1:=0}"
: "${includeSvtav1:=1}"
: "${includeX264:=1}"
: "${includeX265:=1}"
: "${includeVpx:=1}"
: "${includeVmaf:=1}"
: "${skipToFfmpeg:=0}"

requireAptPackages autoconf automake build-essential cmake libass-dev libfreetype6-dev libmp3lame-dev libtool libvorbis-dev meson ninja-build pkg-config texinfo wget yasm zlib1g-dev libunistring-dev libaribb24-dev curl

otherReposFolder="$buildFolder/git"
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
  --enable-encoder=webvtt

  # Select muxers
  --disable-muxers
  --enable-muxer=webm
  --enable-muxer=null

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

if [ "$includeNasm" -gt 0 ] && [ "$skipToFfmpeg" -eq 0 ]; then
  cd "$nonGitSourcesFolder"
  curl --fail --location https://www.nasm.us/pub/nasm/releasebuilds/$nasmVersion/nasm-$nasmVersion.tar.bz2 --output nasm.tar.bz2
  tar xjvf nasm.tar.bz2
  rm nasm.tar.bz2
  cd nasm-$nasmVersion
  mkdir --parents build
  cd build
  ../autogen.sh
  ../configure --prefix="$buildFolder" --bindir="$tempBinFolder"
  make
  make install
fi

# Based on libfdk-aac section from https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu

if [ "$includeAac" -gt 0 ]; then
  makeflags+=(--enable-libfdk-aac)
  makeflags+=(--enable-encoder=libfdk_aac)
  if [ "$skipToFfmpeg" -eq 0 ]; then
    gitClone mstorsjo/fdk-aac
    cd "$otherReposFolder/fdk-aac"
    mkdir --parents build
    cd build
    ../autogen.sh
    ../configure --prefix="$buildFolder" --disable-shared
    make
    make install
  fi
fi

# Based on libopus section from https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu

if [ "$includeOpus" -gt 0 ]; then
  makeflags+=(--enable-libopus)
  makeflags+=(--enable-encoder=libopus)
  if [ "$skipToFfmpeg" -eq 0 ]; then
    gitClone xiph/opus
    cd "$otherReposFolder/opus"
    mkdir --parents build
    cd build
    ../autogen.sh
    ../configure --prefix="$buildFolder" --disable-shared
    make
    make install
  fi
fi

# videolan/dav1d

if [ "$includeDav1d" -gt 0 ]; then
  makeflags+=(--enable-libdav1d)
  if [ "$skipToFfmpeg" -eq 0 ]; then
    gitClone videolan/dav1d # Mirror of https://aomedia.googlesource.com/aom
    cd "$otherReposFolder/dav1d"
    mkdir --parents build
    cd build
    meson setup --buildtype=release --default-library=static --prefix "$buildFolder" --bindir="$tempBinFolder" --libdir="$buildFolder/lib" ..
    ninja
    ninja install
  fi
fi

# Based on https://www.iiwnz.com/build-ffmpeg-av1-svt

if [ "$includeAomav1" -gt 0 ]; then
  makeflags+=(--enable-libaom)
  makeflags+=(--enable-encoder=libaom-av1)
  if [ "$skipToFfmpeg" -eq 0 ]; then
    gitClone jbeich/aom # Mirror of https://aomedia.googlesource.com/aom
    cd "$otherReposFolder/aom"
    mkdir --parents build
    cd build
    cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$buildFolder" -DENABLE_SHARED=off -DENABLE_NASM=on ..
    make
    make install
  fi
fi

# Based on https://www.iiwnz.com/build-ffmpeg-av1-svt

if [ "$includeSvtav1" -gt 0 ]; then
  makeflags+=(--enable-libsvtav1)
  makeflags+=(--enable-encoder=libsvtav1)
  if [ "$skipToFfmpeg" -eq 0 ]; then
    gitClone AOMediaCodec/SVT-AV1
    cd "$otherReposFolder/SVT-AV1"
    mkdir --parents build
    cd build
    cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$buildFolder" -DCMAKE_BUILD_TYPE=Release -DBUILD_DEC=OFF -DBUILD_SHARED_LIBS=OFF ..
    make
    make install
  fi
fi

# Based on ?

if [ "$includeX264" -gt 0 ]; then
  makeflags+=(--enable-libx264)
  if [ "$skipToFfmpeg" -eq 0 ]; then
    gitClone mirror/x264
    cd "$otherReposFolder/x264"
    mkdir --parents build
    cd build
    ../configure --enable-static --prefix="$buildFolder"
    make
    make install
  fi
fi

if [ "$includeX265" -gt 0 ]; then
  makeflags+=(--enable-libx265)
  if [ "$skipToFfmpeg" -eq 0 ]; then
    gitClone videolan/x265
    cd "$otherReposFolder/x265/build/linux"
    cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$buildFolder" -DENABLE_SHARED=off ../../source
    make
    make install
  fi
fi

if [ "$includeVpx" -gt 0 ]; then
  makeflags+=(--enable-libvpx)
  if [ "$skipToFfmpeg" -eq 0 ]; then
    gitClone webmproject/libvpx
    cd "$otherReposFolder/libvpx"
    mkdir --parents build
    cd build
    ../configure --prefix="$buildFolder" --enable-static --disable-shared --disable-docs --disable-tools --disable-unit-tests --disable-examples
    make
    make install
  fi
fi

# Based on libvmaf section from https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu

if [ "$includeVmaf" -gt 0 ]; then
  makeflags+=(--enable-libvmaf)
  makeflags+=(--enable-encoder=wrapped_avframe)
  makeflags+=(--enable-encoder=pcm_s16le)
  makeflags+=(--enable-filter=libvmaf)
  makeflags+=(--enable-filter=setpts)
  if [ "$skipToFfmpeg" -eq 0 ]; then
    cd "$nonGitSourcesFolder"
    curl --location --fail https://github.com/Netflix/vmaf/archive/v$vmafVersion.tar.gz --output vmaf.tar.gz
    tar xvf vmaf.tar.gz
    rm vmaf.tar.gz
    mkdir --parents vmaf-$vmafVersion/libvmaf/build
    cd vmaf-$vmafVersion/libvmaf/build
    meson setup -Denable_tests=false -Denable_docs=false --buildtype=release --default-library=static --prefix "$buildFolder" --bindir="$tempBinFolder" --libdir="$buildFolder/lib" ..
    ninja
    ninja install
  fi
fi

gitClone FFmpeg/FFmpeg
cd "$otherReposFolder/FFmpeg"
PKG_CONFIG_PATH="$buildFolder/lib/pkgconfig" ./configure --prefix="$otherReposFolder" --bindir="$tempBinFolder" --pkg-config-flags="--static" --extra-cflags="-march=native -I$buildFolder/include" --extra-libs="-lpthread -lm" --ld=g++ --extra-ldflags="-L$buildFolder/lib" "${makeflags[@]}"
make
make install

cp --force "$tempBinFolder/ffmpeg" "$userBinFolder"
du -hsb "$userBinFolder/ffmpeg"

cp --force "$tempBinFolder/ffprobe" "$userBinFolder"
du -hsb "$userBinFolder/ffprobe"
