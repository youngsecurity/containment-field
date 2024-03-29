#!/bin/bash

################################################################################
# Script Name: docker-run-wolf.sh
# Description: This script will deploy Wolf
# Author: Joseph Young <joe@youngsecurity.net>
# Created: 2024/01/02
# Version: 1.0
################################################################################

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
#VAR1="value1"
#VAR2="value2"

# Define functions
deploy_container() {
    docker run \
        --name wolf \
        --network macvlan255 \
        --ip=10.0.255.145 \
        -e TZ=America/New_York \
        -e WOLF_LOG_LEVEL=DEBUG \
        -e WOLF_RENDER_NODE=/dev/dri/renderD129 \
        -e XDG_RUNTIME_DIR=/tmp/sockets \
        -v /tmp/sockets:/tmp/sockets:rw \
        -e NVIDIA_DRIVER_VOLUME_NAME=nvidia-driver-vol \
        -v nvidia-driver-vol:/usr/nvidia:rw \
        -e HOST_APPS_STATE_FOLDER=/etc/wolf \
        -v /etc/wolf/wolf:/wolf/cfg \
        -v /var/run/docker.sock:/var/run/docker.sock:rw \
        --device-cgroup-rule "c 13:* rmw" \
        --device /dev/nvidia-uvm \
        --device /dev/nvidia-uvm-tools \
        --device /dev/dri/ \
        --device /dev/nvidia-caps/nvidia-cap1 \
        --device /dev/nvidia-caps/nvidia-cap2 \
        --device /dev/nvidiactl \
        --device /dev/nvidia0 \
        --device /dev/nvidia-modeset \
        --device /dev/uinput \
        -v /dev/shm:/dev/shm:rw \
        -v /dev/input:/dev/input:rw \
        -v /run/udev:/run/udev:rw \
        ghcr.io/games-on-whales/wolf:dev-input-protocol
}

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Call a function
deploy_container

# Do some other things...
#echo "Variable 1 is: $VAR1"
#echo "Variable 2 is: $VAR2"

# Notify the user the script has completed.
echo "Script has finished!"
