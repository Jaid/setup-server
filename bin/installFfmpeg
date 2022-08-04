#!/usr/bin/env bash
set -o errexit

: "${buildFolder:="$HOME/.cache/ffmpegBuild"}"
: "${userBinFolder:="$HOME/bin"}"
: "${nasmVersion:=2.15.05}"
: "${vmafVersion:=2.3.1}"
: "${globalPkgconfig:=/usr/lib/x86_64-linux-gnu/pkgconfig}"
: "${fresh:=0}"

: "${includeNasm:=1}"
: "${includeAac:=2}"
: "${includeOpus:=1}"
: "${includeDav1d:=2}"
: "${includeAomav1:=0}"
: "${includeSvtav1:=1}"
: "${includeX264:=2}"
: "${includeX265:=1}"
: "${includeVpx:=2}"
: "${includeVmaf:=1}"
: "${skipToFfmpeg:=0}"

# 0 = disable completely
# 1 = use self-compilation
# 2 = disable self-compilation, use global installation

stylePink=$(tput setaf 5)
styleOrange=$(tput setaf 172)
styleBold=$(tput bold)
styleReset=$(tput sgr0)

function logHeader() {
  declare -r input=${*:-$(</dev/stdin)}
  printf "$styleBold$stylePink### %s ###$styleReset\n" "$input"
}

requireAptPackages autoconf automake build-essential cmake libass-dev libfreetype6-dev libmp3lame-dev libtool libvorbis-dev meson ninja-build pkg-config texinfo wget yasm zlib1g-dev libunistring-dev libaribb24-dev

otherReposFolder="$buildFolder/git"
nonGitSourcesFolder="$buildFolder/src"
tempBinFolder="$buildFolder/bin"
logFolder="$buildFolder/log"

if [ "$fresh" -gt 0 ]; then
  rm -rf "$buildFolder"
fi

mkdir --parents "$nonGitSourcesFolder"
mkdir --parents "$logFolder"

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
  --disable-devices
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

if [ "$includeNasm" -eq 1 ] && [ "$skipToFfmpeg" -eq 0 ]; then
  printf %s 'NASM: compile' | logHeader
  {
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
  } >"$buildFolder/log/nasm_out.log" 2>"$buildFolder/log/nasm_err.log"
fi

# Based on libfdk-aac section from https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu

if [ "$includeAac" -gt 0 ]; then
  printf %s 'AAC: include' | logHeader
  makeflags+=(--enable-libfdk-aac)
  makeflags+=(--enable-encoder=libfdk_aac)
  if [ "$skipToFfmpeg" -eq 0 ]; then
    if [ "$includeAac" -eq 1 ]; then
      printf %s 'AAC: compile' | logHeader
      {
        gitClone mstorsjo/fdk-aac
        cd "$otherReposFolder/fdk-aac"
        mkdir --parents build
        cd build
        ../autogen.sh
        ../configure --prefix="$buildFolder" --disable-shared
        make
        make install
      } >"$buildFolder/log/aac_out.log" 2>"$buildFolder/log/aac_err.log"
    else
      requireAptPackages libfdk-aac-dev
    fi
  fi
fi

# Based on libopus section from https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu

if [ "$includeOpus" -gt 0 ]; then
  printf %s 'Opus: include' | logHeader
  makeflags+=(--enable-libopus)
  makeflags+=(--enable-encoder=libopus)
  if [ "$skipToFfmpeg" -eq 0 ]; then
    if [ "$includeOpus" -eq 1 ]; then
      printf %s 'Opus: compile' | logHeader
      {
        gitClone xiph/opus
        cd "$otherReposFolder/opus"
        mkdir --parents build
        cd build
        ../autogen.sh
        ../configure --prefix="$buildFolder" --disable-shared
        make
        make install
      } >"$buildFolder/log/opus_out.log" 2>"$buildFolder/log/opus_err.log"
    else
      requireAptPackages libopus-dev
    fi
  fi
fi

# videolan/dav1d

if [ "$includeDav1d" -gt 0 ]; then
  printf %s 'Dav1d: include' | logHeader
  makeflags+=(--enable-libdav1d)
  if [ "$skipToFfmpeg" -eq 0 ]; then
    if [ "$includeDav1d" -eq 1 ]; then
      printf %s 'Dav1d: compile' | logHeader
      {
        gitClone videolan/dav1d
        cd "$otherReposFolder/dav1d"
        mkdir --parents build
        cd build
        meson setup --buildtype=release --default-library=static --prefix "$buildFolder" --bindir="$tempBinFolder" --libdir="$buildFolder/lib" ..
        ninja
        ninja install
      } >"$buildFolder/log/dav1d_out.log" 2>"$buildFolder/log/dav1d_err.log"
    else
      requireAptPackages libdav1d-dev
    fi
  fi
fi

# Based on https://www.iiwnz.com/build-ffmpeg-av1-svt

if [ "$includeAomav1" -gt 0 ]; then
  printf %s 'AOM AV1: include' | logHeader
  makeflags+=(--enable-libaom)
  makeflags+=(--enable-encoder=libaom-av1)
  if [ "$skipToFfmpeg" -eq 0 ]; then
    if [ "$includeAomav1" -eq 1 ]; then
      printf %s 'AOM AV1: compile' | logHeader
      {
        gitClone jbeich/aom # Mirror of https://aomedia.googlesource.com/aom
        cd "$otherReposFolder/aom"
        mkdir --parents build
        cd build
        cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$buildFolder" -DENABLE_SHARED=off -DENABLE_NASM=on ..
        make
        make install
      } >"$buildFolder/log/aom-av1_out.log" 2>"$buildFolder/log/aom-av1_err.log"
    else
      printf >&2 'Error: No global package for AOM AV1\n'
      exit 1
    fi
  fi
fi

# Based on https://www.iiwnz.com/build-ffmpeg-av1-svt

if [ "$includeSvtav1" -gt 0 ]; then
  printf %s 'SVT-AV1: include' | logHeader
  makeflags+=(--enable-libsvtav1)
  makeflags+=(--enable-encoder=libsvtav1)
  if [ "$skipToFfmpeg" -eq 0 ]; then
    if [ "$includeSvtav1" -eq 1 ]; then
      printf %s 'SVT-AV1: compile' | logHeader
      {
        gitClone https://gitlab.com/AOMediaCodec/SVT-AV1
        cd "$otherReposFolder/SVT-AV1"
        mkdir --parents build
        cd build
        cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$buildFolder" -DCMAKE_BUILD_TYPE=Release -DBUILD_DEC=OFF -DBUILD_SHARED_LIBS=OFF ..
        make
        make install
      } >"$buildFolder/log/svt-av1_out.log" 2>"$buildFolder/log/svt-av1_err.log"
    else
      requireAptPackages libsvtav1-dev
    fi
  fi
fi

# Based on ?

if [ "$includeX264" -gt 0 ]; then
  printf %s 'x264: include' | logHeader
  makeflags+=(--enable-libx264)
  if [ "$skipToFfmpeg" -eq 0 ]; then
    if [ "$includeX264" -eq 1 ]; then
      printf %s 'x264: compile' | logHeader
      {
        gitClone mirror/x264
        cd "$otherReposFolder/x264"
        mkdir --parents build
        cd build
        ../configure --enable-static --prefix="$buildFolder"
        make
        make install
      } >"$buildFolder/log/x264_out.log" 2>"$buildFolder/log/x264_err.log"
    else
      requireAptPackages libx264-dev
    fi
  fi
fi

if [ "$includeX265" -gt 0 ]; then
  printf %s 'x265: include' | logHeader
  makeflags+=(--enable-libx265)
  if [ "$skipToFfmpeg" -eq 0 ]; then
    if [ "$includeX265" -eq 1 ]; then
      printf %s 'x265: compile' | logHeader
      {
        gitClone videolan/x265
        cd "$otherReposFolder/x265/build/linux"
        cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$buildFolder" -DENABLE_SHARED=off ../../source
        make
        make install
      } >"$buildFolder/log/x265_out.log" 2>"$buildFolder/log/x265_err.log"
    else
      requireAptPackages libx265-dev libnuma-dev
    fi
  fi
fi

if [ "$includeVpx" -gt 0 ]; then
  printf %s 'vpx: include' | logHeader
  makeflags+=(--enable-libvpx)
  if [ "$skipToFfmpeg" -eq 0 ]; then
    if [ "$includeVpx" -eq 1 ]; then
      printf %s 'vpx: compile' | logHeader
      {
        gitClone webmproject/libvpx
        cd "$otherReposFolder/libvpx"
        mkdir --parents build
        cd build
        ../configure --prefix="$buildFolder" --enable-static --disable-shared --disable-docs --disable-tools --disable-unit-tests --disable-examples
        make
        make install
      } >"$buildFolder/log/vpx_out.log" 2>"$buildFolder/log/vpx_err.log"
    else
      requireAptPackages libvpx-dev
    fi
  fi
fi

# Based on libvmaf section from https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu

if [ "$includeVmaf" -gt 0 ]; then
  printf %s 'VMAF: include' | logHeader
  makeflags+=(--enable-libvmaf)
  makeflags+=(--enable-encoder=wrapped_avframe)
  makeflags+=(--enable-encoder=pcm_s16le)
  makeflags+=(--enable-filter=libvmaf)
  makeflags+=(--enable-filter=setpts)
  if [ "$skipToFfmpeg" -eq 0 ]; then
    if [ "$includeVmaf" -eq 1 ]; then
      printf %s 'VMAF: compile' | logHeader
      {
        cd "$nonGitSourcesFolder"
        curl --location --fail https://github.com/Netflix/vmaf/archive/v$vmafVersion.tar.gz --output vmaf.tar.gz
        tar xvf vmaf.tar.gz
        rm vmaf.tar.gz
        mkdir --parents vmaf-$vmafVersion/libvmaf/build
        cd vmaf-$vmafVersion/libvmaf/build
        meson setup -Denable_tests=false -Denable_docs=false --buildtype=release --default-library=static --prefix "$buildFolder" --bindir="$tempBinFolder" --libdir="$buildFolder/lib" ..
        ninja
        ninja install
      } >"$buildFolder/log/vmaf_out.log" 2>"$buildFolder/log/vmaf_err.log"
    else
      printf >&2 'Error: No global package for VMAF\n'
      exit 1
    fi
  fi
fi

logHeader FFmpeg
{
  gitClone FFmpeg/FFmpeg
  cd "$otherReposFolder/FFmpeg"
  PKG_CONFIG_PATH="$globalPkgconfig:$buildFolder/lib/pkgconfig" ./configure --prefix="$otherReposFolder" --bindir="$tempBinFolder" --pkg-config-flags='--static' --extra-cflags="-march=native -I$buildFolder/include" --extra-libs="-lpthread -lm" --ld=g++ --extra-ldflags="-L$buildFolder/lib" "${makeflags[@]}"
  make
  make install
} >"$buildFolder/log/ffmpeg_out.log" 2>"$buildFolder/log/ffmpeg_err.log"

logHeader Finishing

cp --force "$tempBinFolder/ffmpeg" "$userBinFolder"
du -hsb "$userBinFolder/ffmpeg"

cp --force "$tempBinFolder/ffprobe" "$userBinFolder"
du -hsb "$userBinFolder/ffprobe"
