#!/bin/bash

# .SCRIPT NAME: docker-run-update-"$container".sh
# .AUTHOR: Joseph Young <joe@youngsecurity.net>
# .DATE: 01/12/2025
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

# Check the source for the latest release version
VERSION=""
OWNER="portainer"
DOCKER_REPO="portainer-ce"
CONTAINERNAME="portainer"

# Attempt to fetch the latest release tag name using curl and jq.
IMAGE_TAG=$(curl -s "https://hub.docker.com/v2/repositories/$OWNER/$DOCKER_REPO/tags/?page=1" | \
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

# Setup the container using specific '.tag_name'
echo "Pulling container image..."
docker pull "$OWNER"/"$DOCKER_REPO":"$VERSION"

# Stopping the container
echo "Stopping the container..."
docker container stop "$CONTAINERNAME"

# Delete existing Pi-hole
echo "Deleting existing container..."
docker rm -f "$CONTAINERNAME"
echo "Container removed!"

# Starting up the container...
echo "Starting up the container..."

docker run -itd \
    --gpus '"device=0,1"' \
    --network=macvlan255 \
    --ip 10.0.255.XXX \
    -p 8000:8000 -p 9443:9443 \
    --hostname "$CONTAINERNAME" \
    --name "$CONTAINERNAME" \
    --restart=unless-stopped \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    --restart always \
    -e TZ=America/New_York \
    "$DOCKER_REPO":"$TAG_NAME"

# Notify the user the script has completed.
echo "Script has finished!"