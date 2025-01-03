#!/usr/bin/env bash

# Clone Kernel
git clone --recursive --depth=1 -j $(nproc) $REPO -b $BRANCH $KERNELNAME
cd $KERNELNAME

# Clone Clang
git clone --recursive --depth=1 -j $(nproc) $CLANGREPO -b $CLANGBRANCH clang
PATH="${PWD}/clang/bin:${PATH}"

IMAGE=$(pwd)/out/arch/arm64/boot/Image.gz-dtb
DATE=$(date +"%Y%m%d-%H%M")
START=$(date +"%s")
KERNEL_DIR=$(pwd)
ARCH=arm64
export ARCH
KBUILD_BUILD_HOST="RenzAlt"
export KBUILD_BUILD_HOST
KBUILD_BUILD_USER="KernelCI"
export KBUILD_BUILD_USER

# Compile
compile() {

    if [ -d "out" ]; then
        rm -rf out && mkdir -p out
    fi

    make O=out ARCH="${ARCH}"
    make $DEFCONFIG O=out
    make -j $(nproc --all) O=out \
        ARCH=$ARCH \
        CC="clang" \
        AR="llvm-ar" \
        NM="llvm-nm" \
        OBJCOPY="llvm-objcopy" \
        OBJDUMP="llvm-objdump" \
        READELF="llvm-readelf" \
        OBJSIZE="llvm-size" \
        STRIP="llvm-strip" \
        LLVM_AR="llvm-ar" \
        LLVM_DIS="llvm-dis" \
        CROSS_COMPILE=aarch64-linux-gnu- \
        CROSS_COMPILE_ARM32=arm-linux-gnueabi-

    if ! [ -a "$IMAGE" ]; then
        finderr
        exit 1
    fi

    wget https://raw.githubusercontent.com/shenprjkt/Alts-KernelCI/main/Common/AnyKernel.sh
    bash AnyKernel.sh
    cp out/arch/arm64/boot/Image.gz-dtb Anykernel3
}

compile
