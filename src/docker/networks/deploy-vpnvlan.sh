#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
infName="tun0"
#ipv4="10.0.255.60/32"
subnet="10.6.0.0/17"
#ipRange="10.0.255.144/28"
gatewayIP="10.6.0.1"
#localDNS="10.0.255.24/32"
netName="vpnvlan"
netType="bridge" # choose from bridge, host, overlay, macvlan, none, custom
#auxAddress1="network-address=10.0.255.144"
#auxAddress2="broadcast-address=10.0.255.159"

# Define functions
function deploy_Macvlan() {

    docker network create -d $netType \
        --subnet=$subnet \
        --gateway=$gatewayIP \
        -o parent="$infName" \
        $netName
}

function deploy_Bridge() {
    sudo ip link add "$netName" link "$infName" type "$netType" mode bridge    
    sudo ip link set "$netName" up
}

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Call a function
deploy_Macvlan

# Notify the user the script has completed.
echo "Script has finished!"