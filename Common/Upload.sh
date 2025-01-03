#!/usr/bin/env bash

DATE=$(date +"%Y%m%d-%H%M")
START=$(date +"%s")

tgs() {
    MD5=$(md5sum "$1" | cut -d' ' -f1)
    curl -fsSL -X POST -F document=@"$1" https://api.telegram.org/bot"$TOKEN"/sendDocument \
        -F "chat_id=$CHAT_ID" \
        -F "parse_mode=Markdown" \
        -F "caption=$2 | *MD5*: \`$MD5\`"
}

# Push kernel to channel
push() {
    cd AnyKernel || exit 1
    ZIP=$(echo *.zip)
    tgs "${ZIP}" "Build took $((DIFF / 60)) minute(s) and $((DIFF % 60)) second(s). | For $DEVICENAME "
}

END=$(date +"%s")
DIFF=$((END - START))
push
