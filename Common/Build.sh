#!/usr/bin/env bash
mkdir mkdir -p output

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

# Compile
compile() {

    if [ -d "out" ]; then
        rm -rf output && mkdir -p output
    fi

    make -C $(pwd) O=output \
    VARIANT_DEFCONFIG=msm8916_sec_j5lte_eur_defconfig \
    SELINUX_DEFCONFIG=selinux_defconfig
    make -C $(pwd) O=output

    if ! [ -a "$IMAGE" ]; then
        finderr
        exit 1
    fi

    git clone --depth=1 https://github.com/imnathanzero/AnyKernel3.git AnyKernel -b j5
    cp output/arch/arm/boot/Image AnyKernel/zImage

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
