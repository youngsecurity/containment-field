
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
docker run -d \
  --device /dev/dri/ \
  --name=games-on-whales \
  --restart=unless-stopped \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=America/New_York \
  -v <path to data>:/config \
  -p 47984-47990:47984-47990/tcp \
  -p 48010:48010 \
  -p 47998-48000:47998-48000/udp \
  gow-sunshine
  }