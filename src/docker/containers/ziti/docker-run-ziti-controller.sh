#!/bin/sh

################################################################################
# Script Name: docker-run-ziti-controller.sh
# Description: This script will deploy ziti-controller
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
deploy_ziti_controller() {
    docker run \
        -it \
        --rm \
        --name ziti-controller \
        --network macvlan255 \
        --ip=10.0.255.147 \
        --network-alias ziti-controller \
        --network-alias ziti-edge-controller \
        -p 1280:1280 \
        -e ZITI_CTRL_ADVERTISED_ADDRESS=ziti-edge-controller \
        -v myPersistentZitiFiles:/persistent \
        openziti/quickstart \
        /var/openziti/scripts/run-controller.sh
}

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Call a function
deploy_ziti_controller

# Do some other things...
#echo "Variable 1 is: $VAR1"
#echo "Variable 2 is: $VAR2"

# Notify the user the script has completed.
echo "Script has finished!"