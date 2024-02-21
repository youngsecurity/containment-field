#!/bin/bash

# .SCRIPT NAME: docker-run-ollama-webui.sh
# .AUTHOR: Joseph Young <joe@youngsecurity.net>
# .DATE: 02/21/2024
# .DOCUMENTATION: 
#   This script will perform the following tasks:
#       1. Pull the latest container image from the registry
#       2. Stop and delete the existing container
#       3. Start the Docker container and run it detached, interactive and allocate a pseudo-TTY
# .DESCRIPTION: This is a Docker run shell script to update a container.
# .EXAMPLE: ./docker-run-ollama-webui.sh <arguments>

# Exit immediately if a command exits with a non-zero status
set -e

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Check GitHub for latest release version
# PowerShell
#(Invoke-RestMethod -Uri "https://api.github.com/repos/pi-hole/docker-pi-hole/releases/latest" | Select-Object -ExpandProperty tag_name)
# Shell
#TAG_NAME=$(curl -s https://api.github.com/repos/pi-hole/docker-pi-hole/releases/latest | jq -r '.tag_name')

# Setup the container using specific '.tag_name'
echo "Pulling image..."
#docker pull pihole/pihole:"$TAG_NAME"
docker pull ghcr.io/open-webui/open-webui:latest

# Stopping the container
echo "Stopping the container..."
docker container stop open-webui-ext

# Delete existing
echo "Deleting existing container..."
docker rm -f open-webui-ext
echo "Container removed!"

# Starting up the container...
echo "Starting up the container..."

docker run -itd \
    --network=macvlan255 \
    --ip 10.0.255.148 \
    --restart always \
    --name open-webui-ext \
    -e OLLAMA_API_BASE_URL=http://10.0.255.147:11434/api \
    -v open-webui:/app/backend/data \
    open-webui:latest

# Notify the user the script has completed.
echo "Script has finished!"