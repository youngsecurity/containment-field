#!/bin/sh

# sudoers.d setup
sudo touch /etc/sudoers.d/devusr
sudo visudo --file=/etc/sudoers.d/devusr
devusr ALL=(ALL) NOPASSWD:ALL
# or
sudo echo "devusr ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/devusr

###################################################################
# apt update and upgrade
sudo apt update
sudo apt -y upgrade
# There's a bug in the Ubuntu upgrade process, where two packages 
# need to be upgraded, but they depend on each other and neither 
# wants to go first. Use the following command to resolve the bug.
# sudo apt --only-upgrade install $packageName

###################################################################
# SSH & PKI Configuration
# start the ssh-agent
eval "$(ssh-agent -s)"
# check for ssh key
ssh-add -l -E sha256
# if it doesn't exist, then add it to the ssh-agent
ssh-add ~/.ssh/id_carl_rsa_2048.pri


###################################################################
# Ubuntu Firewall (UFW) Configuration
# Setup MGMT services whitelist for a dedicated MGMT VLAN
# Setup DMZ services whitelist for a dedicated DMZ VLAN
sudo ufw allow from 10.0.0.0/8 to any port 81 # PiHole MGMT
sudo ufw allow from 10.0.0.0/8 to any port 53 # PiHole DNS
sudo ufw allow from 10.0.0.0/8 to any port 9001 # portainer agents
sudo ufw allow from 10.0.255.0/24 to any port 9443 # portainer UI
sudo ufw allow from 10.0.255.0/24 to any port 8000 # portainer optional for Edge compute
sudo ufw allow from 10.0.255.0/24 to any port 8080 # nginx dev container
sudo ufw allow from 10.0.255.0/24 to any port 22 # ssh
sudo ufw enable

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