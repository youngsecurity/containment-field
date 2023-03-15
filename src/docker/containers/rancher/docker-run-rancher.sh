#!/bin/sh
# Setup Rancher using rootless Docker user namespace
docker run -itd \
-p 8000:8000 -p 9443:9443 \
--name=rancher \
--restart=unless-stopped \
-v /$XDG_RUNTIME_DIR/docker.sock:/var/run/docker.sock \
-v ~/.local/share/docker/volumes:/var/lib/docker/volumes \
-v rancher_data:/data \
rancher/rancher:latest