#!/usr/bin/env bash

# Copyright 2024

tgp() {
    curl -sX POST https://api.telegram.org/bot"$TOKEN"/sendPhoto -d photo=$PHOTO -d chat_id="$CHAT_CH" -d parse_mode=Markdown -d disable_web_page_preview=true -d text="$1" &>/dev/null -d caption="New Kernel Build For
$KERNELNAME $DEVICENAME
Author: @natehiggas00

🔹[Changelog]($CHANGELOG)
🔹[Download]($DOWNLOAD)

Notes: 
ea"
}

# Send Build Info
sendinfo() {
    tgp 
}

sendinfo
