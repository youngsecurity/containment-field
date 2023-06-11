#!/bin/sh

################################################################################
# Script Name: deploy-kasm.sh
# Description: This is script installs Kasm Workspaces.
# Author: Joseph Young <joe@youngsecurity.net>
# Created: 2023/06/08
# Version: 1.0
################################################################################

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
#VAR1="value1"
#VAR2="value2"

# Define functions
function my_function() {
  echo "Hello, world!"
}

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Call a function
deploy_kasm

# Do some other things...
#echo "Variable 1 is: $VAR1"
#echo "Variable 2 is: $VAR2"

#curl -O https://kasm-static-content.s3.amazonaws.com/kasm_release_1.13.1.421524.tar.gz
#tar -xf kasm_release_1.13.1.421524.tar.gz
sudo bash kasm_release/install.sh --enable-lossless --proxy-port 8443 -L 443


# Notify the user the script has completed.
echo "Script has finished!"