#!/bin/bash
# Setup Portainer Agent
docker pull portainer/agent:2.20.1 &&\
docker stop portainer_agent &&\
docker rm -f portainer_agent &&\
docker run -itd \
  -p 9001:9001 \
  --name portainer_agent \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/docker/volumes:/var/lib/docker/volumes \
  portainer/agent:2.20.1
