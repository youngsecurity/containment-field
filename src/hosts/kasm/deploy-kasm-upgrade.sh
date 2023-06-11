#!/bin/sh

################################################################################
# Script Name: deploy-kasm.sh
# Description: This is script upgrades Kasm Workspaces. Before starting the 
#              upgrade process please ensure that the Web App servers are 
#              stopped. If left running there is a chance for database corruption
#              on the Webb App servers. The upgrade script can be found in the
#              installation package under `kasm_release/upgrade.sh`.
#              These instructions assume there are 3 servers with the app, db,
#              and agent roles.
# Author: Joseph Young <joe@youngsecurity.net>
# Created: 2023/06/11
# Version: 1.0
################################################################################

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
#VAR1="value1"
#VAR2="value2"

# Define functions
function upgrade_kasm() {
  # Before starting the upgrade process please ensure that the Web App servers are
  # stopped. If left running there is a chance for database corruption on the Web 
  # App servers
  sudo /opt/kasm/bin/stop

  # Download the latest Kasm release
  cd /tmp
  curl -O https://kasm-static-content.s3.amazonaws.com/kasm_release_1.13.1.421524.tar.gz
  tar -xf kasm_release_1.13.1.421524.tar.gz

  # Login to the db server and execute:  
  sudo bash kasm_release/upgrade.sh --role db

  # Login to the agent server and execute:
  sudo bash kasm_release/upgrade.sh --role agent

  # Login to the Web App server and execute:
  sudo bash kasm_release/upgrade.sh --role app

  # Login to the connection proxy server and execute:
  sudo bash kasm_release/upgrade.sh --role guac



  #curl -O https://kasm-static-content.s3.amazonaws.com/kasm_release_1.13.1.421524.tar.gz
  tar -xf kasm_release_1.13.1.421524.tar.gz
  sudo bash kasm_release/upgrade.sh --enable-lossless --proxy-port 4443


}

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Call a function
upgrade_kasm

# Do some other things...
#echo "Variable 1 is: $VAR1"
#echo "Variable 2 is: $VAR2"

# Notify the user the script has completed.
echo "Script has finished!"