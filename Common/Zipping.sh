#!/usr/bin/env bash

DATE=$(date +"%Y%m%d-%H%M")
START=$(date +"%s")

# Zipping
zipping() {
    cd AnyKernel3 || exit 1
    zip -Alts kernel-testing-$KERNELNAME-"${DATE}".zip ./*
    cd ..
}

zipping
END=$(date +"%s")
DIFF=$((END - START))
