#!/bin/bash

# Check if IP address is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <ip_address> [private_key_path]"
    exit 1
fi

# Set the IP address from the script argument
IP_ADDRESS="$1"

# Set the optional SSH key path from the script argument
PRIVATE_KEY_PATH="$2"

# Check if a private key path is provided and set the -i option accordingly
if [ -n "$PRIVATE_KEY_PATH" ]; then
    SSH_OPTIONS="-i $PRIVATE_KEY_PATH"
else
    SSH_OPTIONS=""
fi

# SSH into the remote server and restart webui.service
ssh $SSH_OPTIONS "ubuntu@${IP_ADDRESS}" "sudo systemctl restart webui.service"
