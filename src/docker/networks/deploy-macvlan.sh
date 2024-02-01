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
interfaceName="eth0"
#VAR2="value2"

# Define functions
#function my_function() {
#    echo "Hello, world!"
#}

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Call a function
#my_function

# Do some other things...
#echo "Variable 1 is: $VAR1"
#echo "Variable 2 is: $VAR2"

sudo ip link set "$interfaceName" promisc on

docker network create -d macvlan \
    --subnet=10.0.255.0/24 \
    --ip-range=10.0.255.144/28 \
    --gateway=10.0.255.1 \
    -o parent="$interfaceName" macvlan255

# Notify the user the script has completed.
echo "Script has finished!"