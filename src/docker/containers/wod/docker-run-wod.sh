#!/bin/bash
# .AUTHOR: Joseph Young <joe@youngsecurity.net>
# Exit immediately if a command exits with a non-zero status
set -e
# Main code
echo -e "Script is running..."
echo ""
#LOG_FILE="./run.log" # Log file for errors and output messages.
docker run -itd \
    --gpus '"device=GPU-fcc90235-d4c3-65e4-f064-446367f1cb5c"' \
    --network=macvlan255 \
    --ip 10.0.255.154 \
    -p 8006:8006 \
    --name=windows \
    --device=/dev/kvm \
    --cap-add NET_ADMIN \
    --stop-timeout 120 \
    --restart always \
    dockurr/windows