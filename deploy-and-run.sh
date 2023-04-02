#!/bin/bash

# Check if IP address is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <ip_address>"
    exit 1
fi

# Set the IP address from the script argument
IP_ADDRESS="$1"

# SCP the run.sh file to the remote server
scp run.sh config.json "ubuntu@${IP_ADDRESS}:"

# SSH into the remote server and run run.sh
ssh "ubuntu@${IP_ADDRESS}" "chmod +x run.sh && ./run.sh && bash"
