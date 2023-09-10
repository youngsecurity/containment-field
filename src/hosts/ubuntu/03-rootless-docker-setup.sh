#!/bin/bash

###################################################################
# apt update and upgrade
#
# sudo apt update
# sudo apt -y upgrade
#
# There's a bug in the Ubuntu upgrade process, where two packages 
# need to be upgraded, but they depend on each other and neither 
# wants to go first. Use the following command to resolve the bug.
# sudo apt --only-upgrade install $packageName
##################################################################
# The following changes are required for rootless Docker
###################################################################
# /etc/sysctl.conf conf required to support rootless docker
# Routing ping packets for rootless Docker
# net.ipv4.ping_group_range = 0 2147483647
###################################################################
# Define the desired value for net.ipv4.ping_group_range
route_ping_packets="net.ipv4.ping_group_range = 0 2147483647"

# Check if /etc/sysctl.conf exists
if [ -e "/etc/sysctl.conf" ]; then
    # Check if net.ipv4.ping_group_range is already set to the desired value
    if grep -q "^$route_ping_packets" /etc/sysctl.conf; then
        echo "net.ipv4.ping_group_range is already set to the desired value."
    else
        # Update net.ipv4.ping_group_range to the desired value
        echo "Updating net.ipv4.ping_group_range to the desired value..."
        sed -i "s/^.*net\.ipv4\.ping_group_range.*$/$route_ping_packets/" /etc/sysctl.conf
        echo "net.ipv4.ping_group_range has been updated."
        
        # Apply the changes immediately
        sysctl -p
    fi
else
    echo "Error: /etc/sysctl.conf does not exist."
fi
###################################################################
# The 'net.ipv4.ip_unprivileged_port_start' setting in Ubuntu is
# used to specify the lowest port number that can be used by 
# unprivileged processes when binding to a network socket.
# The default is set to 1024, which means only processes running as
# root can bind to ports below 1024
# net.ipv4.ip_unprivileged_port_start = 0
###################################################################
# Define the desired value for net.ipv4.ip_unprivileged_port_start
lowest_priv_port_number="net.ipv4.ip_unprivileged_port_start = 0"

# Check if /etc/sysctl.conf exists
if [ -e "/etc/sysctl.conf" ]; then
    # Check if net.ipv4.ip_unprivileged_port_start is already set to the desired value
    if grep -q "^$lowest_priv_port_number" /etc/sysctl.conf; then
        echo "net.ipv4.ip_unprivileged_port_start is already set to the desired value."
    else
        # Update net.ipv4.ip_unprivileged_port_start to the desired value
        echo "Updating net.ipv4.ip_unprivileged_port_start to the desired value..."
        sed -i "s/^.*net\.ipv4\.ip_unprivileged_port_start.*$/$lowest_priv_port_number/" /etc/sysctl.conf
        echo "net.ipv4.ip_unprivileged_port_start has been updated."
        
        # Apply the changes immediately
        sysctl -p
    fi
else
    echo "Error: /etc/sysctl.conf does not exist."
fi
###################################################################
# After modifying /etc/sysctl.conf, run the following command to 
# activate the changes.
# sudo sysctl -p