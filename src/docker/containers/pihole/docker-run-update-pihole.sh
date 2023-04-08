#!/bin/sh

# .SCRIPT NAME: docker-run-update-pihole.sh
# .AUTHOR: Joseph Young <joe@youngsecurity.net>
# .DATE: 3/22/2023
# .DOCUMENTATION: https://github.com/pi-hole/docker-pi-hole#readme
#   This script will perform the following tasks:
#       1. Remove the Docker container named "pihole"
#       2. Pull the latest Pi-hole image from Docker Hub
#       3. Setup the Docker Pi-hole container and run it detached, interactive and allocate a pseudo-TTY
# .DESCRIPTION: This is a Docker run shell script to update Docker Pi-hole.
# .EXAMPLE: ./docker-run-update-pihole.sh <arguments>

# Exit immediately if a command exits with a non-zero status
set -e

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Delete existing Pi-hole
echo "Deleting existing Pi-hole..."
docker rm -f pihole
echo "Pi-hole container removed!"

# Setup pihole using specific tag, because the :latest tag does not always pull down the latest version
echo "Pulling the latest Pi-hole image..."
# docker pull pihole/pihole:latest
docker pull pihole/pihole:2023.03.01

# Note: FTLCONF_LOCAL_IPV4 should be replaced with your external ip.
docker run -itd \
    --name pihole \
    -p 53:53/tcp -p 53:53/udp \
    -p 81:80 \
    -e TZ=America/New_York \
    -v etc-pihole:/etc/pihole/ \
    -v etc-dnsmasq.d:/etc/dnsmasq.d/ \
    --dns=127.0.0.1 --dns=8.8.8.8 \
    --restart=unless-stopped \
    --hostname pihole \
    -e VIRTUAL_HOST="pihole" \
    -e PROXY_LOCATION="pihole" \
    -e FTLCONF_LOCAL_IPV4="127.0.0.1" \
    --net=Transit \
    pihole/pihole:2023.02.2

printf 'Starting up pihole container '
for i in $(seq 1 20); do
    if [ "$(docker inspect -f "{{.State.Health.Status}}" pihole)" == "healthy" ] ; then
        printf ' OK'
        #echo -e "\n$(docker logs pihole 2> /dev/null | grep 'password:') for your pi-hole: http://${IP}/admin/"
        exit 0
    else
        sleep 3
        printf '.'
    fi

    if [ $i -eq 20 ] ; then
        echo -e "\nTimed out waiting for Pi-hole start, consult your container logs for more info (\`docker logs pihole\`)"
        exit 1
    fi
done;

# Notify the user the script has completed.
echo "Script has finished!"