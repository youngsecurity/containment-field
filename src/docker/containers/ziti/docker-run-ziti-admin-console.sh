#!/bin/sh

################################################################################
# Script Name: docker-run-ziti-admin-console.sh
# Description: This script will deploy ziti-admin-console
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
deploy_ziti_admin_console() {
    docker run \
        -it \
        --name ziti-admin-console \
        --network macvlan255 \
        -p 1408:1408 \
        -p 8443:8443 \
        -v "${HOME}/docker-volume/macvlan255/ziti-edge-controller-intermediate/keys/ziti-edge-controller-server.key":/usr/src/app/server.key \
        -v "${HOME}/docker-volume/macvlan255/ziti-edge-controller-intermediate/certs/ziti-edge-controller-server.chain.pem":/usr/src/app/server.chain.pem \
        openziti/zac
}

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Call a function
deploy_ziti_admin_console

# Do some other things...
#echo "Variable 1 is: $VAR1"
#echo "Variable 2 is: $VAR2"

# Notify the user the script has completed.
echo "Script has finished!"