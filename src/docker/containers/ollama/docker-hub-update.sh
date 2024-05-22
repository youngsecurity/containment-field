#!/bin/bash

# .SCRIPT NAME: docker-hub-update.sh
# .AUTHOR: Joseph Young <joe@youngsecurity.net>
# .DATE: 05/18/2024
# .DOCUMENTATION: 
#   This script will perform the following tasks:
#       1. Check and pull the latest version of the container image
#       2. Stop and remove the container
#       3. Start the container and run it detached, interactive and allocate a pseudo-TTY
# .DESCRIPTION: This is a shell script to update a container.
# .EXAMPLE: ./docker-hub-update.sh <arguments>

# Exit immediately if a command exits with a non-zero status
set -e

# Main code
echo "Starting the script!"
#TAG_NAME=""
VERSION=""
OWNER="ollama"
REPO="ollama"
CONTAINERNAME="ollama"

# Attempt to fetch the latest release tag name using curl and jq.
IMAGE_TAG=$(curl -s "https://hub.docker.com/v2/repositories/$OWNER/$REPO/tags/?page=1" | \
    grep -oP 'linux-amd64-[0-9]+\.[0-9]+\.[0-9]+' | head -n 1) # Extracts only the version number.

if [ $? -ne 0 ]; then
    echo "Error: Failed to fetch tags from Docker Hub." >&2
    exit 1
fi

# Check if IMAGE_TAG is not empty, otherwise print an error message and exit.
if [ -z "$IMAGE_TAG" ]; then
    echo "Error: No matching image tag found on Docker Hub for $OWNER/$REPO." >&2
else
    # If the command was successful, strip any remaining characters that are not part of the version number (e.g., '-alpine').
    VERSION=$(echo "$IMAGE_TAG" | sed 's/.*-//; s/-[a-z]*$//')
    echo "$VERSION"
fi

# Setup the container
echo "Pulling $CONTAINERNAME image..."
docker pull "$OWNER"/"$REPO":"$VERSION"