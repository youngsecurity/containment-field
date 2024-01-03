#!/bin/bash

# .SCRIPT NAME: docker-run-update-pihole.sh
# .AUTHOR: Joseph Young <joe@youngsecurity.net>
# .DATE: 12/04/2023
# .DOCUMENTATION: https://github.com/pi-hole/docker-pi-hole#readme
#   This script will perform the following tasks:
#       1. Pull the latest Pi-hole image from Docker Hub
#       2. Remove the Docker container named "pihole"
#       3. Setup the Docker Pi-hole container and run it detached, interactive and allocate a pseudo-TTY
# .DESCRIPTION: This is a Docker run shell script to update Docker Pi-hole.
# .EXAMPLE: ./docker-run-update-pihole.sh <arguments>

# Exit immediately if a command exits with a non-zero status
set -e

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Check GitHub for latest release version
#(Invoke-RestMethod -Uri "https://api.github.com/repos/pi-hole/pi-hole/releases/latest" | Select-Object -ExpandProperty tag_name)
curl -s https://api.github.com/repos/pi-hole/pi-hole/releases/latest | jq -r '.tag_name'

# Check Docker Hub for latest Docker image version
imageSource=pihole/pihole:latest
docker pull $imageSource
docker image inspect $imageSource | jq -r '.[].RepoDigests[]' | awk -F@ '{print $2}'
# shellcheck disable=SC1035
digest=$(!!)
version=$(curl -s 'https://hub.docker.com/v2/repositories/pihole/pihole/tags' -H 'Content-Type: application/json' | jq -r '.results[] | select(.digest == "'"$digest"'") | .name' | sed -n 2p)
# Setup pihole using specific tag, because the :latest tag does not always pull down the latest version
echo "Pulling Pi-hole image..."
# docker pull pihole/pihole:latest
docker pull pihole/pihole:"$version"

# Shutting down the stack
#echo "Shutting down the stack..."
#docker compose down

# Stopping the container
echo "Stopping the container..."
docker container stop pihole

# Delete existing Pi-hole
echo "Deleting existing Pi-hole..."
docker rm -f pihole
echo "Pi-hole container removed!"

# Starting the stack...
#echo "Starting up the stack..."
#docker compose up -d

# Starting up the container...
echo "Starting up the container..."
#docker run -itd -p 81:80 -p 53:53/tcp -p 53:53/udp --name=pihole --net=Transit --ip=10.10.10.5 --restart=always -h pihole -e TZ=America/New_York -v etc-pihole:/etc/pihole/ -v etc-dnsmasq.d:/etc/dnsmasq.d/ pihole/pihole:2023.05.2
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
    pihole/pihole:2023.11.0

printf 'Starting up pihole container '
for i in $(seq 1 30); do
    if [ "$(docker inspect -f "{{.State.Health.Status}}" pihole)" == "healthy" ] ; then
        printf ' OK'
        echo -e "\n$(docker logs pihole 2> /dev/null | grep 'password:') for your pi-hole: http://${IP}/admin/"
        exit 0
    else
        sleep 3
        printf '.'
    fi

    if [ "$i" -eq 30 ] ; then
        echo -e "\nTimed out waiting for Pi-hole start, consult your container logs for more info (\`docker logs pihole\`)"
        #exit 1
    fi
done;

# Notify the user the script has completed.
echo "Script has finished!"