#!/bin/bash
# .AUTHOR: Joseph Young <joe@youngsecurity.net>
# Exit immediately if a command exits with a non-zero status
set -e
# Main code
echo -e "Script is running..."
echo ""

LOG_FILE="./run.log" # Log file for errors and output messages.

# Source the environment file if it exists and exit if it does not.
ENV_FILE="./.env"

if [ -f "$ENV_FILE" ]; then
    # shellcheck source=.env
    source "$ENV_FILE"
else
    echo "Info: No .env loaded" | tee -a "$LOG_FILE"
    echo "Error: Variables must be provided." | tee -a "$LOG_FILE" >&2
    echo "" >> $LOG_FILE
    echo "Script has finished with errors, check \"run.log\"!"    
    exit 1
fi

# ports required when not using macvlan
#    -p 8006:8006 \
#    -p 3389:3389/tcp \
#    -p 3380:3389/udp \
# credentials, default user is docker with a blank pass
#    -e USERNAME="devusr" \
#    -e PASSWORD="" \

deploy_container(){
    echo ""
    echo "Deploying container: $CONTAINERNAME..."
    docker run -it \
    --gpus '"device=GPU-fcc90235-d4c3-65e4-f064-446367f1cb5c"' \
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
    -e RAM_SIZE="8G" \
    --stop-timeout 120 \
    --restart always \
    dockurr/windows

}
deploy_container "$@"

