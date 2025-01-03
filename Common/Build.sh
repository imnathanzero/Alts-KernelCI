#!/usr/bin/env bash

# Clone Kernel
git clone --recursive --depth=1 -j $(nproc) $REPO -b $BRANCH $KERNELNAME
cd $KERNELNAME

# Clone Clang
git clone --recursive --depth=1 -j $(nproc) $CLANGREPO -b $CLANGBRANCH $CLANGNAME
PATH="${PWD}/$CLANGNAME/bin:${PATH}"
