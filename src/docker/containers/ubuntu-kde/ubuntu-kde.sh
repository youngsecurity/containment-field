#!/bin/sh
# docker command to create a webtop:ubuntu-kde container
docker run -itd --name=ubuntu-kde -h ubuntu-kde --privileged -e PUID=1000 -e PGID=1000 -e TZ=America/New_York -p 1000:3000 --net=Transit --dns=10.0.255.46  --restart=always linuxserver/webtop:ubuntu-kde