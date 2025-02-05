#!/bin/sh

################################################################################
# Script Name: docker-run-macos-ventura.sh
# Description: This script deploys a pre-installed macOS Ventura Version 13
# Author: Joseph Young <joe@youngsecurity.net>
# Created: 02/03/2025
################################################################################

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
#VAR1="value1"
#VAR2="value2"

# Define functions
deploy_macos_catalina() {
# 40GB disk space required: 20GB original image 20GB your container.
docker pull sickcodes/docker-osx:latest

# boot directly into a real OS X shell with a visual display [NOT HEADLESS]
docker run -it \
    --device /dev/kvm \
    -p 50922:10022 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e "DISPLAY=${DISPLAY:-:0.0}" \
    -e GENERATE_UNIQUE=true \
    -e MASTER_PLIST_URL='https://raw.githubusercontent.com/sickcodes/osx-serial-generator/master/config-custom.plist' \
    -e SHORTNAME=ventura \
    sickcodes/docker-osx:latest

# username is user
# passsword is alpine
}

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Call a function
deploy_macos_catalina

# Do some other things...
#echo "Variable 1 is: $VAR1"
#echo "Variable 2 is: $VAR2"

# Notify the user the script has completed.
echo "Script has finished!"