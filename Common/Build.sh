#!/usr/bin/env bash

# Clone Kernel
git clone --recursive --depth=1 -j $(nproc) $REPO -b $BRANCH $KERNELNAME
cd $KERNELNAME

# Clone Clang
git clone --recursive --depth=1 -j $(nproc) $CLANGREPO -b $CLANGBRANCH $CLANGNAME
PATH="${PWD}/$CLANGNAME/bin:${PATH}"

IMAGE=$(pwd)/out/arch/arm64/boot/Image.gz-dtb
DATE=$(date +"%Y%m%d-%H%M")
START=$(date +"%s")
KERNEL_DIR=$(pwd)
ARCH=arm64
export ARCH
KBUILD_BUILD_HOST="$HOST"
export KBUILD_BUILD_HOST
KBUILD_BUILD_USER="$USER"
export KBUILD_BUILD_USER
