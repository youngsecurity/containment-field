#!/bin/bash

################################################################################
# Script Name: deploy-macvlan.sh
# Description: This script will deploy a macvlan.
# Author: Joseph Young <joe@youngsecurity.net>
# Created: 2024/02/01
# Version: 1.0
################################################################################

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
infName="eth0"
subnet="10.0.255.0/24"
ipRange="10.0.255.144/28"
gatewayIP="10.0.255.1"
netName="macvlan255"
netType="macvlan" # choose from bridge, host, overlay, macvlan, none, custom

# Define functions
function deploy_Macvlan() {
    sudo ip link set "$infName" promisc on

    docker network create -d $netType \
        --subnet=$subnet \
        --gateway=$gatewayIP \
        --ip-range=$ipRange \
        --aux-address="reserved1=10.0.255.144" \
        -o parent="$infName" $netName
}

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Call a function
deploy_Macvlan

# Notify the user the script has completed.
echo "Script has finished!"