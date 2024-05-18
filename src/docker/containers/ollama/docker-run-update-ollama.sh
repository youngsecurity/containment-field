#!/bin/bash

# .SCRIPT NAME: docker-run-update-ollama.sh
# .AUTHOR: Joseph Young <joe@youngsecurity.net>
# .DATE: 01/25/2024
# .DOCUMENTATION: 
#   This script will perform the following tasks:
#       1. Check and pull the latest version of the container image from GitHub
#       2. Stop and remove the Docker container
#       3. Start the Docker container and run it detached, interactive and allocate a pseudo-TTY
# .DESCRIPTION: This is a Docker run shell script to update a container.
# .EXAMPLE: ./docker-run-update-"$container".sh <arguments>

# Exit immediately if a command exits with a non-zero status
set -e

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Check GitHub for latest release version
# Using PowerShell
#(Invoke-RestMethod -Uri "https://api.github.com/repos/pi-hole/docker-pi-hole/releases/latest" | Select-Object -ExpandProperty tag_name)
# Using Bash
TAG_NAME=$(curl -s https://api.github.com/repos/ollama/ollama/releases/latest | jq -r '.tag_name')

# Setup the container using specific '.tag_name'
echo "Pulling container image..."
docker pull ollama/ollama:"$TAG_NAME"

# Stopping the container
echo "Stopping the container..."
docker container stop ollama

# Delete existing Pi-hole
echo "Deleting existing Pi-hole..."
docker rm -f ollama
echo "Pi-hole container removed!"

# Starting up the container...
echo "Starting up the container..."

docker run -itd \
    --gpus=0 \
    --network=macvlan255 \
    --ip=10.0.255.147 \
    -p 11434:11434 \
    -v ollama:/root/.ollama \
    --hostname ollama \
    --name ollama \
    --restart=always \
    -e TZ=America/New_York \
    ollama/ollama:latest

# Notify the user the script has completed.
echo "Script has finished!"