#!/bin/sh

###################################################################
# apt update and upgrade
sudo apt update
sudo apt -y upgrade
# There's a bug in the Ubuntu upgrade process, where two packages 
# need to be upgraded, but they depend on each other and neither 
# wants to go first. Use the following command to resolve the bug.
# sudo apt --only-upgrade install $packageName

# The following changes are required for rootless Docker

###################################################################
# /etc/sysctl.conf conf required to support rootless docker
# Routing ping packets for rootless Docker
net.ipv4.ping_group_range = 0 2147483647

###################################################################
# The 'net.ipv4.ip_unprivileged_port_start' setting in Ubuntu is
# used to specify the lowest port number that can be used by 
# unprivileged processes when binding to a network socket.
# The default is set to 1024, which means only processes running as
# root can bind to ports below 1024
net.ipv4.ip_unprivileged_port_start = 0

###################################################################
# After modifying /etc/sysctl.conf, run the following command to 
# activate the changes.
sudo sysctl -p