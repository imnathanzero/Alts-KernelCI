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
KBUILD_BUILD_HOST="Nathan"
export KBUILD_BUILD_HOST
KBUILD_BUILD_USER="WasHere"
export KBUILD_BUILD_USER

# Compile
compile() {

    if [ -d "out" ]; then
        rm -rf out && mkdir -p out
    fi

    make CC=clang ARCH="${ARCH}" O=out $DEFCONFIG
    make CC=clang LLVM=1 ARCH="${ARCH}" -j $(nproc --all) O=out \
        HEADER_ARCH=arm64 \
        SUBARCH=arm64 \
        CXX=c++ \
        AR=llvm-ar \
        NM=llvm-nm \
        OBJDUMP=llvm-objdump \
        STRIP=llvm-strip \
        READELF=llvm-readelf \
        HOSTCXX=clang++ \
        HOSTAR=llvm-ar \
        LLVM_IAS=1 \
        HOSTCFLAGS="-fuse-ld=lld -Wno-unused-command-line-argument" \
        CROSS_COMPILE=~/TC/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-gnu-7.5/bin/aarch64-linux-gnu- \
        CROSS_COMPILE_ARM32=~/TC/prebuilts/gcc/linux-x86/arm/arm-linux-gnueabihf-7.5/bin/arm-linux-gnueabihf- \
        CLANG_TRIPLE=~/TC/proton-clang/bin/aarch64-linux-gnu-

    if ! [ -a "$IMAGE" ]; then
        finderr
        exit 1
    fi

    git clone --depth=1 https://github.com/Frostleaft07/Anykernel3 AnyKernel -b rmx1941 
    cp out/arch/arm64/boot/Image.gz-dtb AnyKernel

}

# Zipping
zipping() {
    cd AnyKernel || exit 1
    zip -r9 Alts-"${BRANCH}"-"${DEVICENAME}"-"${DATE}".zip ./*
    cd ..
}

tgs() {
    MD5=$(md5sum "$1" | cut -d' ' -f1)
    curl -fsSL -X POST -F document=@"$1" https://api.telegram.org/bot"$TOKEN"/sendDocument \
        -F chat_id="$CHAT_ID" \
        -F "parse_mode=Markdown" \
        -F "caption=$2 | *MD5*: \`$MD5\`"
}

# Push kernel to channel
push() {
    cd AnyKernel || exit 1
    ZIP=$(echo *.zip)
    tgs "${ZIP}" "Build took $((DIFF / 60)) minute(s) and $((DIFF % 60)) second(s). | For $DEVICENAME "
}

compile
zipping
END=$(date +"%s")
DIFF=$((END - START))
push
