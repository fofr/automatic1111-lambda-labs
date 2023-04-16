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

# SCP the run.sh file to the remote server
scp $SSH_OPTIONS -o StrictHostKeyChecking=accept-new run.sh config.json webui.service "ubuntu@${IP_ADDRESS}:"

# SSH into the remote server and set up webui.service and configure passwordless sudo
ssh $SSH_OPTIONS "ubuntu@${IP_ADDRESS}" "sudo mv webui.service /etc/systemd/system/ && sudo chown root:root /etc/systemd/system/webui.service && sudo chmod 644 /etc/systemd/system/webui.service && echo 'ubuntu ALL=(ALL) NOPASSWD: /bin/systemctl' | sudo tee /etc/sudoers.d/webui"

# SSH into the remote server and run run.sh
ssh $SSH_OPTIONS "ubuntu@${IP_ADDRESS}" "chmod +x run.sh && screen -S webui -dm bash -c './run.sh; exec sh'"
