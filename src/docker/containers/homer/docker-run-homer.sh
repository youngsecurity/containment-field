#!/bin/sh

# .SCRIPT NAME: docker-run-homer.sh
# .AUTHOR: Joseph Young <joe@youngsecurity.net>
# .DATE: 3/22/2023
# .DOCUMENTATION: https://github.com/redlinejoes/homer#readme
#   This script will perform the following tasks:
#       1. Remove the existing Docker container
#       2. Pull the latest image
#       3. Setup the container and run it
# .DESCRIPTION: This is a Docker run shell script to update Docker Homer.
# .EXAMPLE: ./docker-run-homer.sh <arguments>

# Exit immediately if a command exits with a non-zero status
set -e

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Delete existing Pi-hole
echo "Deleting existing container..."
docker rm -f homer
echo "Container removed!"

# Pull the latest image
echo "Pulling the latest image..."
docker pull b4bz/homer:latest

# Note: The container will run using a user uid and gid 1000. Add --user <your-UID>:<your-GID> to the docker command to adjust it. Make sure this match the ownership of your assets directory.
docker run -d \
    -p 8080:8080 \
    -v </your/local/assets/>:/www/assets \
    --restart=always \
    b4bz/homer:latest

printf 'Starting up container...'

# Notify the user the script has completed.
echo "Script has finished!"