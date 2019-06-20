#!/bin/bash

[[ -z $(command -v wget) ]] && { echo "wget is required to for this script"; exit 1; }

usage() {
    echo "get_thing <id>" && exit 1
}

[[ $# -lt 1 ]] && usage

THING_ID="$1"


wget https://www.thingiverse.com/thing:$THING_ID/zip -O temp_zip.zip -o download.log
TARGET_DIR=$(cat download.log | grep "Location" | grep -o "[a-zA-Z0-9_-]*\.zip"|cut -d "." -f1)
rm -f download.log
mkdir -p "$TARGET_DIR"
mv temp_zip.zip "$TARGET_DIR"
cd "$TARGET_DIR"
unzip temp_zip.zip
rm -f temp_zip.zip

