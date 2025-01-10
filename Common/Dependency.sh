#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y build-essential clang bc bison libssl-dev libfl-dev libncurses5-dev libzstd-dev libtinfo5
sudo apt-get install -y curl git ftp lftp wget libarchive-tools ccache python2 python2-dev python3
sudo apt-get install -y zip unzip tar gzip bzip2 rar unrar cpio
          
git clone --depth=1 https://gitlab.com/LeCmnGend/clang.git -b clang-19 ~/TC/proton-clang
git clone --depth=1 https://github.com/P-Salik/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-gnu-7.5.git -b master ~/TC/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-gnu-7.5
