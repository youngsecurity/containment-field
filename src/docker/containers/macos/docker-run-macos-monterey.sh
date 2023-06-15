#!/bin/sh

################################################################################
# Script Name: docker-run-macos-monterey.sh
# Description: This script deploys macOS Monterey Version 12
# Author: Joseph Young <joe@youngsecurity.net>
# Created: 2023/06/15
# Version: 1.0
################################################################################

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
#VAR1="value1"
#VAR2="value2"

# Define functions
function deploy_macos_monterey() {
docker run -it \
  --device /dev/kvm \
  -p 50922:10022 \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e "DISPLAY=${DISPLAY:-:0.0}" \
  -e GENERATE_UNIQUE=true \
  -e MASTER_PLIST_URL='https://raw.githubusercontent.com/sickcodes/osx-serial-generator/master/config-custom.plist' \
  sickcodes/docker-osx:monterey
# docker build -t docker-osx --build-arg SHORTNAME=monterey .
}

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Call a function
deploy_macos_monterey

# Do some other things...
#echo "Variable 1 is: $VAR1"
#echo "Variable 2 is: $VAR2"

# Notify the user the script has completed.
echo "Script has finished!"