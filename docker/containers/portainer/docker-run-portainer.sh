#!/bin/sh
# Setup Portainer on using rootless Docker user namespace
docker run -d \
  -p 8000:8000 -p 9443:9443 \
  --name=portainer \
  --restart=unless-stopped \
  -v /$XDG_RUNTIME_DIR/docker.sock:/var/run/docker.sock \
  -v ~/.local/share/docker/volumes:/var/lib/docker/volumes \
  -v portainer_data:/data \
  portainer/portainer-ce:2.16.2