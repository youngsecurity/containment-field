#!/bin/bash

# Setup the container using specific '.tag_name'
echo "Pulling container image..."
docker pull "$OWNER"/"$DOCKER_REPO":"$VERSION"

# Stopping the container
echo "Stopping the container..."
docker container stop "$CONTAINERNAME"

# Delete existing Pi-hole
echo "Deleting existing container..."
docker rm -f "$CONTAINERNAME"
echo "Container removed!"

# Starting up the container...
echo "Starting up the container..."

docker run -itd \
    --gpus '"device=0,1"' \
    --network=macvlan255 \
    --ip 10.0.255.XXX \
    -p 8000:8000 -p 9443:9443 \
    --hostname "$CONTAINERNAME" \
    --name "$CONTAINERNAME" \
    --restart=unless-stopped \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    --restart always \
    -e TZ=America/New_York \
    "$DOCKER_REPO":"$TAG_NAME"

docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.21.5