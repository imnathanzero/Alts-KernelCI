#!/usr/bin/env bash

# Clone Kernel
git clone --recursive --depth=1 -j $(nproc) $REPO -b $BRANCH $KERNELNAME

# Clone Toolchain
git clone --recursive --depth=1 -j $(nproc) https://github.com/nathanzerogarage/android-prebuilts-gcc-linux-x86-arm-arm-eabi-7.2.git prebuilts/gcc/linux-x86/arm/arm-eabi-7.2
cd $KERNELNAME

# Clone Clang
git clone --recursive --depth=1 -j $(nproc) $CLANGREPO -b $CLANGBRANCH clang
PATH="${PWD}/clang/bin:${PATH}"

IMAGE=$(pwd)/output/arch/arm/boot/Image
DATE=$(date +"%Y%m%d-%H%M")
START=$(date +"%s")
KERNEL_DIR=$(pwd)
ARCH=arm
export ARCH
KBUILD_BUILD_HOST="nathan"
export KBUILD_BUILD_HOST
KBUILD_BUILD_USER="openthe3xit"
export KBUILD_BUILD_USER
export CROSS_COMPILE=$(pwd)/prebuilts/gcc/linux-x86/arm/arm-eabi-7.2/bin/arm-eabi-
