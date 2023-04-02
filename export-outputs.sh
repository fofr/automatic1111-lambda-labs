#!/bin/bash

# Check if IP address is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <ip_address>"
    exit 1
fi

# Set the IP address from the script argument
IP_ADDRESS="$1"

REMOTE_USER="ubuntu"
REMOTE_DIR="stable-diffusion-webui/outputs"
LOCAL_DIR="outputs"

while true; do
    rsync -az --backup --suffix=.1 --exclude='*.tmp' "${REMOTE_USER}@${IP_ADDRESS}:${REMOTE_DIR}/" "${LOCAL_DIR}"
    if [ $? -ne 0 ]; then
        echo "Error occurred. Exiting the loop."
        break
    fi
    sleep 10
done
