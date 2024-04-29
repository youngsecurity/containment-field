#!/bin/bash

set -e

# Define variables
name="ns1"
network="macvlan255"
ip="10.0.255.24"
timezone="TZ=America/New_York"
image="ubuntu/bind9:9.18-22.04_beta"

# Define functions
deploy_container() {
    docker run -itd \
    --name $name \
    --network $network \
    --ip=$ip \
    --restart=unless-stopped \
    -e BIND9_USER=bind \
    -e $timezone \
    -v ns1_config:/etc/bind \
    -v ns1_cache:/var/cache/bind \
    -v ns1_records:/var/lib/bind \
    -p 53:53/tcp \
    -p 53:53/udp \
    $image
}

# Notify the user the script has started.
echo "Starting the script!"

# Main code

# Call a function
deploy_container

# Notify the user the script has completed. 
echo "Script has finished!"