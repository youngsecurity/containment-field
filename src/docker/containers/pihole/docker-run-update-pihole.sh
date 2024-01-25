#!/bin/bash

# .SCRIPT NAME: docker-run-update-pihole.sh
# .AUTHOR: Joseph Young <joe@youngsecurity.net>
# .DATE: 01/25/2024
# .DOCUMENTATION: https://github.com/pi-hole/docker-pi-hole#readme
#   This script will perform the following tasks:
#       1. Check and pull the latest version of the container image from GitHub
#       2. Stop and remove the Docker container
#       3. Start the Docker container and run it detached, interactive and allocate a pseudo-TTY
# .DESCRIPTION: This is a Docker run shell script to update a container.
# .EXAMPLE: ./docker-run-update-pihole.sh <arguments>

# Exit immediately if a command exits with a non-zero status
set -e

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Check GitHub for latest release version
# PowerShell
#(Invoke-RestMethod -Uri "https://api.github.com/repos/pi-hole/docker-pi-hole/releases/latest" | Select-Object -ExpandProperty tag_name)
# Shell
TAG_NAME=$(curl -s https://api.github.com/repos/pi-hole/docker-pi-hole/releases/latest | jq -r '.tag_name')

# Setup the container using specific '.tag_name'
echo "Pulling Pi-hole image..."
docker pull pihole/pihole:"$TAG_NAME"

# Stopping the container
echo "Stopping the container..."
docker container stop pihole

# Delete existing Pi-hole
echo "Deleting existing Pi-hole..."
docker rm -f pihole
echo "Pi-hole container removed!"

# Starting up the container...
echo "Starting up the container..."

docker run -itd \
    -p 53:53/tcp -p 53:53/udp \
    -p 81:80 \
    --name=pihole \
    --net=Transit \
    --ip=10.10.10.5 \
    --restart=always \
    --hostname pihole \
    -e TZ=America/New_York \
    -e VIRTUAL_HOST="pihole" \
    -v etc-pihole:/etc/pihole/ \
    -v etc-dnsmasq.d:/etc/dnsmasq.d/ \
    -e PROXY_LOCATION="pihole" \
    pihole/pihole:"$TAG_NAME"

# Notify the user the script has completed.
echo "Script has finished!"