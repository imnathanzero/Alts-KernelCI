#!/usr/bin/env bash

DATE=$(date +"%Y%m%d-%H%M")
START=$(date +"%s")

git clone --depth=1 https://github.com/imnathanzero/AnyKernel3.git AnyKernel -b j5
cp $(pwd)/output/arch/arm/boot/Image AnyKernel/zImage

# Zipping
zipping() {
    cd AnyKernel3 || exit 1
    zip -Alts kernel-testing-$KERNELNAME-"${DATE}".zip ./*
    cd ..
}

zipping
END=$(date +"%s")
DIFF=$((END - START))
