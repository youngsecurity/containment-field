#!/bin/sh

docker run \
    --name wolf \
    --network=host \
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
    ghcr.io/games-on-whales/wolf:stable