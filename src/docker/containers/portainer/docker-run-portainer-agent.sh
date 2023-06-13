#!/bin/sh
# Setup Portainer Agent using rootless Docker user namespace
docker run -itd \
  -p 9001:9001 \
  --name portainer_agent \
  --restart=always \
  -v /$XDG_RUNTIME_DIR/docker.sock:/var/run/docker.sock \
  -v ~/.local/share/docker/volumes:/var/lib/docker/volumes \
  portainer/agent:2.18.3
