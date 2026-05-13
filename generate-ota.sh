#!/bin/bash

set -e

RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
NC="\033[0m"

ROM_DIR="out/target/product/peridot"
BASE_URL="https://zenin1504.dpdns.org/peridot/pixelos/"
VERSION=16

latest_zip=$(find "$ROM_DIR" -maxdepth 1 -type f -name "PixelOS*.zip" -printf "%T@ %p\n" \
| sort -n | tail -1 | cut -d' ' -f2-)

if [[ -z "$latest_zip" ]]; then
    echo -e "${RED}No PixelOS zip found${NC}"
    exit 1
fi

filename=$(basename "$latest_zip")
echo -e "${GREEN}Using: ${YELLOW}${filename}${NC}"

sha256=$(sha256sum "$latest_zip" | awk '{print $1}')
size=$(stat -c%s "$latest_zip")

datetime=$(grep "^ro.build.date.utc=" "${ROM_DIR}/system/build.prop" | cut -d= -f2 | tr -d '\r')

if [[ -z "$datetime" ]]; then
    echo -e "${RED}Failed to get ro.build.date.utc from system/build.prop${NC}"
    exit 1
fi

find_payload_offset() {
    local build="$1"
    info=$(zipdetails "$build")

    foundBin=0

    while IFS= read -r line; do
        if [[ $foundBin == 1 ]]; then
            echo "$line" | grep -q "PAYLOAD"
            if [[ $? == 0 ]]; then
                hexNum=$(echo "$line" | awk '{print $1}')
                echo $((16#$hexNum))
                return
            fi
            continue
        fi

        echo "$line" | grep -q "payload.bin" && foundBin=1
    done <<< "$info"
}

offset=$(find_payload_offset "$latest_zip")

payload_props=$(unzip -p "$latest_zip" payload_properties.txt 2>/dev/null || true)

FILE_HASH=$(echo "$payload_props" | grep "^FILE_HASH=" | cut -d= -f2)
FILE_SIZE=$(echo "$payload_props" | grep "^FILE_SIZE=" | cut -d= -f2)
METADATA_HASH=$(echo "$payload_props" | grep "^METADATA_HASH=" | cut -d= -f2)
METADATA_SIZE=$(echo "$payload_props" | grep "^METADATA_SIZE=" | cut -d= -f2)

SOURCE_DIR="../pixelos-lab"

timestamp=$(date +%Y%m%d_%H%M%S)

find "$SOURCE_DIR" -maxdepth 1 -type f -name "device*.json" -delete

cat > "${SOURCE_DIR}/device_${timestamp}.json" <<EOF
{
    "response": [
        {
            "datetime": ${datetime},
            "filename": "${filename}",
            "id": "${sha256}",
            "size": ${size},
            "url": "${BASE_URL}/${filename}",
            "version": ${VERSION},
            "stream": false,
            "payload": [
                {
                    "offset": ${offset},
                    "FILE_HASH": "${FILE_HASH}",
                    "FILE_SIZE": "${FILE_SIZE}",
                    "METADATA_HASH": "${METADATA_HASH}",
                    "METADATA_SIZE": "${METADATA_SIZE}"
                }
            ]
        }
    ]
}
EOF

echo -e "${GREEN}Done generating ${SOURCE_DIR}/device_${timestamp}.json${NC}"
