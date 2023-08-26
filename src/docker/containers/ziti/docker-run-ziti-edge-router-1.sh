#!/bin/sh

################################################################################
# Script Name: docker-run-ziti-edge-router-1.sh
# Description: This script will deploy ziti-edge-router-1
# Author: Joseph Young <joe@youngsecurity.net>
# Created: 2023/08/26
# Version: 1.0
################################################################################

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
#VAR1="value1"
#VAR2="value2"

# Define functions
deploy_ziti_edge_router_1() {
    docker run \
        -it \
        --name ziti-edge-router-1 \
        --network macvlan255 \
        --network-alias ziti-edge-router-1 \
        -p 3022:3022 \
        -e ZITI_ROUTER_NAME=ziti-edge-router-1 \
        -e ZITI_ROUTER_ADVERTISED_HOST=ziti-edge-router-1 \
        -e ZITI_ROUTER_ROLES=public \
        -v myPersistentZitiFiles:/persistent \
        openziti/quickstart \
        /var/openziti/scripts/run-router.sh edge
}

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Call a function
deploy_ziti_edge_router_1

# Do some other things...
#echo "Variable 1 is: $VAR1"
#echo "Variable 2 is: $VAR2"

# Notify the user the script has completed.
echo "Script has finished!"