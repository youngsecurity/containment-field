#!/bin/bash
set -e

# Define variables
name="restore-01"
timezone="TZ=America/New_York"
image="alpine"

# Define functions
deploy_container() {
    docker run --rm \
        --name $name \
        -e $timezone \
        -v pihole_etc:/data \
        -v "$(pwd)":/backup \
        $image \
        sh -c "tar xzvf /backup/pihole_etc_backup.tar.gz -C /data"
}

# Call a function
deploy_container
