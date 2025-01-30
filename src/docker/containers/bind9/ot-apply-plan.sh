#!/bin/bash

set -e

# Define variables
name="opentofu-1-9-0"
image="ghcr.io/opentofu/opentofu:1.9.0-amd64"

# Define functions
deploy_container() {
    docker run --rm \
    --name $name \
    --workdir=/srv/workspace \
    --mount type=bind,source=.,target=/srv/workspace \
    $image \
    apply "/srv/workspace/main.plan"
}

# Notify the user the script has started.
echo "Starting the script!"

# Main code

# Call a function
deploy_container

# Notify the user the script has completed. 
echo "Script has finished!"