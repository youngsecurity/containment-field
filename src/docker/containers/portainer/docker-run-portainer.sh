#!/bin/bash

# .SCRIPT NAME: docker-run-update-portainer.sh
# .AUTHOR: Joseph Young <joe@youngsecurity.net>
# .DATE: 12/04/2023
# .DOCUMENTATION:
#   This script will perform the following tasks:
#       1. Pull the latest image from Docker Hub
#       2. Remove the Docker container
#       3. Setup the Docker container and run it detached, interactive and allocate a pseudo-TTY
# .DESCRIPTION: This is a Docker run shell script to update a Docker container.
# .EXAMPLE: ./docker-run-update-portainer.sh <arguments>

# Exit immediately if a command exits with a non-zero status
#set -e

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Check GitHub for latest release version
ghVersion=$(curl -s https://api.github.com/repos/portainer/portainer/releases/latest | jq -r '.tag_name')

# Check Docker Hub for latest Docker image version
imageSource=portainer/portainer-ce:"$ghVersion"
docker pull "$imageSource"
docker image inspect "$imageSource" | jq -r '.[].RepoDigests[]' | awk -F@ '{print $2}'
# shellcheck disable=SC1035
#digest=$(!!)
#version=$(curl -s 'https://hub.docker.com/v2/repositories/portainer/portainer-ce/tags' -H 'Content-Type: application/json' | jq -r '.results[] | select(.digest == "'"$digest"'") | .name' | sed -n 2p)


# Setup container using specific tag, because the :latest tag does not always pull down the latest version
echo "Pulling Docker image..."
docker pull portainer/portainer-ce:"$ghVersion"

# Shutting down the stack
#echo "Shutting down the stack..."
#docker compose down

# Stopping the container
echo "Stopping the container..."
docker container stop portainer

# Delete existing container
echo "Deleting existing container..."
docker rm -f portainer
echo "Container removed!"

# First, create the volume that Portainer Server will use to store its database:
#docker volume create portainer_data

# Starting the stack...
#echo "Starting up the stack..."
#docker compose up -d

# Starting up the container...
echo "Starting up the container..."
docker run -itd \
    -p 8000:8000 -p 9443:9443 \
    --name portainer \
    --restart=unless-stopped \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:"$ghVersion"

# Notify the user the script has completed.
echo "Script has finished!"