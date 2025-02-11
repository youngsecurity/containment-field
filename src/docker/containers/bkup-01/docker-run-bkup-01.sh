#!/bin/bash
set -e

# Define variables
name="bkup-01"
#network="macvlan255"
#ip="10.0.255.24"
timezone="TZ=America/New_York"
image="alpine"

# Define functions
deploy_container() {
    docker run --rm \
        --name $name \
        --restart=unless-stopped \
        -e BIND9_USER=bind \
        -e $timezone \
        -v /var/lib/docker/volumes/pihole_etc:/data \
        -v "$(pwd)":/backup \
        $image \
        sh -c "tar czvf /backup/pihole_etc_backup.tar.gz -C /data ."    
}

# Call a function
deploy_container
