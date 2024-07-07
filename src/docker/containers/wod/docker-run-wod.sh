#!/bin/bash
# .AUTHOR: Joseph Young <joe@youngsecurity.net>
# Exit immediately if a command exits with a non-zero status
set -e
# Main code
echo -e "Script is running..."
echo ""
#LOG_FILE="./run.log" # Log file for errors and output messages.
# ports required when not using macvlan
#    -p 8006:8006 \
#    -p 3389:3389/tcp \
#    -p 3380:3389/udp \
# credentials, default user is docker with a blank pass
#    -e USERNAME="devusr" \
#    -e PASSWORD="" \
docker run -itd \
    --network=macvlan255 \
    --ip 10.0.255.154 \
    --hostname windows \
    --name windows \
    --device=/dev/kvm \
    --cap-add NET_ADMIN \
    -v windows:/storage \
    -v /home/devusr/:/shared \
    -e VERSION="win11e" \
    -e DISK_SIZE="64G" \
    -e CPU_CORES="4" \
    -e RAM_SIZE="8" \
    --stop-timeout 120 \
    --restart always \
    dockurr/windows