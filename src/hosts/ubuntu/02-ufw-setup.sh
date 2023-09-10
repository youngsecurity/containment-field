#!/bin/bash

###################################################################
# Ubuntu Firewall (UFW) Configuration
# The configuration of UFW will depend on your NetSec requirements
# Some options are:
# Setup whitelist for a dedicated MGMT VLAN
# Setup whitelist for a dedicated DMZ VLAN
# 10.0/8 = All LANs
# 10.0.255/24 = Ethernet only, no WiFi without exceptions

sudo ufw allow from 10.0.0.0/8 to any port 81 # PiHole MGMT
sudo ufw allow from 10.0.0.0/8 to any port 53 # PiHole DNS
sudo ufw allow from 10.0.0.0/8 to any port 9001 # portainer agents
sudo ufw allow from 10.0.255.0/24 to any port 9443 # portainer UI
sudo ufw allow from 10.0.255.0/24 to any port 8000 # portainer optional for Edge compute
sudo ufw allow from 10.0.255.0/24 to any port 8080 # nginx dev container
sudo ufw allow from 10.0.255.0/24 to any port 22 # ssh
sudo ufw enable
