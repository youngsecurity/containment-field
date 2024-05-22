#!/bin/bash

# .SCRIPT NAME: ghcr-update.sh
# .AUTHOR: Joseph Young <joe@youngsecurity.net>
# .DATE: 05/18/2024
# .DOCUMENTATION: 
#   This script will perform the following tasks:
#       1. Check and pull the latest version of the container image
#       2. Stop and remove the container
#       3. Start the container and run it detached, interactive and allocate a pseudo-TTY
# .DESCRIPTION: This is a shell script to update a container.
# .EXAMPLE: ./ghcr-update.sh <arguments>

# Exit immediately if a command exits with a non-zero status
set -e

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Check GitHub for latest release version
TAG_NAME=""
OWNER="ollama"
REPO="ollama"

# Attempt to fetch the latest release tag name using curl and jq.
if ! TAG=$(curl -s "https://api.github.com/repos/$OWNER/$REPO/releases/latest"); then
    echo "Error: Failed to get releases information." >&2
    exit 1
fi

# Use jq to parse the JSON response and extract tag name if curl succeeded.
if [ -n "$TAG" ]; then
    TAG_NAME=$(echo "$TAG" | jq -r '.tag_name' | sed 's/^v//') # Remove leading 'v' if present.
else
    echo "Error: Failed to parse release information." >&2
    exit 1
fi

# Output the tag name or an error message if not found.
if [ -z "$TAG_NAME" ]; then
    echo "Error: No tag name found in the latest release." >&2
else
    echo "$TAG_NAME"
fi

# Setup the container using specific '.tag_name'
echo "Pulling container image..."
docker pull """$REPO":"$TAG_NAME"

# Stopping the container
echo "Stopping the container..."
docker container stop ollama

# Delete existing container
echo "Deleting existing container..."
docker rm -f ollama
echo "Container removed!"

# Starting up the container...
echo "Starting up the container..."

docker run -itd \
    --gpus '"device=0"' \
    --network=macvlan255 \
    --ip 10.0.255.147 \
    -p 11434:11434 \
    -v ollama:/root/.ollama \
    --hostname ollama \
    --name ollama \
    --restart always \
    -e TZ=America/New_York \
    "$REPO":"$TAG_NAME"

# Notify the user the script has completed.
echo "Script has finished!"