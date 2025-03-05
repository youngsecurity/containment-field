#!/bin/bash

################################################################################
# Script Name: deploy-macvlan.sh
# Description: This script will deploy a macvlan.
# Author: Joseph Young <joe@youngsecurity.net>
################################################################################

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
infName="eth0"
subnet="10.0.255.0/24"
ipRange="10.0.255.144/28"
gatewayIP="10.0.255.1"
localDNS="10.0.255.24/32"
netName="macvlan255"
netType="macvlan" # choose from bridge, host, overlay, macvlan, none, custom
auxAddress1="network-address=10.0.255.144"
auxAddress2="broadcast-address=10.0.255.159"

# Define functions
function deploy_Macvlan() {
    sudo ip link set "$infName" promisc on

    docker network create -d $netType \
        --subnet=$subnet \
        --gateway=$gatewayIP \
        --ip-range=$ipRange \
        --aux-address=$auxAddress1 \
        --aux-address=$auxAddress2 \
        -o parent="$infName" $netName
}

function deploy_bridge() {
    sudo ip link add "$netName" link "$infName" type "$netType" mode bridge
    sudo ip addr add 10.0.255.60/32 dev "$netName"
    sudo ip link set "$netName" up
    sudo ip route add "$ipRange" dev "$netName" # Add route to the macvlan network for docker dhcp
    sudo ip route add "$localDNS" dev "$netName" # Add route to the macvlan network for local dns
}

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Call a function
deploy_Macvlan

# Notify the user the script has completed.
echo "Script has finished!"