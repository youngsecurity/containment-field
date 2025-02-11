#!/bin/bash

set -e

# Define variables
name=""
HOST_PORT=""
CONTAINER_PORT=""
network="macvlan255"
ip=""
timezone="TZ=America/New_York"
image=""

# Define functions
deploy_container() {
    docker run -itd \
    --name "$name" \
    --network $network \
    --ip="$ip" \
    --restart=unless-stopped \
    -e $timezone \
    -v docker_volume:/path/in/container \
    -v /path/in/host:/path/in/container \
    -p "$HOST_PORT":"$CONTAINER_PORT"/tcp \
    -p "$HOST_PORT":"$CONTAINER_PORT"/udp \
    "$image"
}

# Notify the user the script has started.
echo "Starting the script!"

# Main code

# Call a function
deploy_container

# Notify the user the script has completed. 
echo "Script has finished!"