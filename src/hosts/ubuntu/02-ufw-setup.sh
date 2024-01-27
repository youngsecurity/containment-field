#!/bin/bash

###################################################################
# Ubuntu Firewall (UFW) Configuration
# The configuration of UFW will depend on your NetSec requirements
# Some options are:
# Setup whitelist for a dedicated MGMT VLAN
# Setup whitelist for a dedicated DMZ VLAN
# 10.0/8 = All LANs
# 10.0.255/24 = Management VLAN, GigEthernet only, no WiFi without exceptions, 
# 10.0.254/24 = DMZ, Presentation VLAN
# 10.0.253/24 = Application VLAN
# 10.0.252/24 = Database VLAN
# 10.0.251/24 = Ziti VLAN
# 10.0.5/24 = WiFi/IoT/Mobile-only VLAN
# 10.0.

# Pihole Firewall ACL
## PiHole MGMT
sudo ufw allow from 10.0.0.0/8 to any port 81
## PiHole DNS
sudo ufw allow from 10.0.0.0/8 to any port 53

# Portainer Firewall ACL
## portainer agents
sudo ufw allow from 10.0.0.0/8 to any port 9001
sudo ufw allow from 10.0.255.0/24 to any port 9443 # portainer UI
sudo ufw allow from 10.0.255.0/24 to any port 8000 # portainer optional for Edge compute

# Example Firewall ACL
# nginx dev container 
sudo ufw allow from 10.0.255.0/24 to any port 8080

# SSHd Firewall ACL
sudo ufw allow from 10.0.255.0/24 to any port 22 # ssh

# Start UFW
sudo ufw enable
