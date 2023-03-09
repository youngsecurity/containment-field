#!/bin/sh

# sudoers.d setup
sudo touch /etc/sudoers.d/devusr
sudo visudo --file=/etc/sudoers.d/devusr
devusr ALL=(ALL) NOPASSWD:ALL
# or
sudo echo "devusr ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/devusr

# apt update and upgrade
sudo apt update
sudo apt -y upgrade

# Ubuntu UFW Configuration
sudo ufw allow from 10.0.0.0/8 to any port 9001
sudo ufw allow from 10.0.0.0/8 to any port 1234

# /etc/sysctl.conf configuration required to support rootless docker
###################################################################
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