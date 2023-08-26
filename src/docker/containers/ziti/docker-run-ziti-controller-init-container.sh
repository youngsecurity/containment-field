#!/bin/sh

################################################################################
# Script Name: docker-run-ziti-controller-init-container.sh
# Description: This script will deploy ziti-controller-init-container
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
deploy_ziti_controller_init_container() {
    docker run \
        -it \
        --rm \
        --network macvlan255 \
        --network-alias ziti-controller-init-container \
        -v myPersistentZitiFiles:/persistent \
        openziti/quickstart \
        /var/openziti/scripts/run-with-ziti-cli.sh  /var/openziti/scripts/access-control.sh
}

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Call a function
deploy_ziti_controller_init_container

# Do some other things...
#echo "Variable 1 is: $VAR1"
#echo "Variable 2 is: $VAR2"

# Notify the user the script has completed.
echo "Script has finished!"