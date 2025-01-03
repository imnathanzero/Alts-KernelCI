#!/usr/bin/env bash

# Copyright 2024

tgp() {
    curl -sX POST https://api.telegram.org/bot"$TOKEN"/sendPhoto -d photo=$PHOTO -d chat_id="$CHAT_ID" -d parse_mode=Markdown -d disable_web_page_preview=true -d text="$1" &>/dev/null -d caption="#AltsProject #MI8953
#KERNELNAME $DEVICENAME || Kernel 4.19
Author: @RennAlt

🔹[Changelog]($CHANGELOG)
🔹[Download]($DOWNLOAD)
🔹[Support Group](https://t.me/+DpywKc3nbn42OTE1)

Notes: 

Credits :
• Thanks to bla for the help and reference
• @bla for port msm8953
• @bla For help me in adaptation 4.19
• @bla @bla for help and tester"
}

# Send Build Info
sendinfo() {
    tgp 
}

sendinfo
