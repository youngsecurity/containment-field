#!/bin/sh

################################################################################
# Script Name: shellscript.sh
# Description: This is boilerplate for a shell script.
# Author: Joseph Young <joe@youngsecurity.net>
# Created: 2023/05/22
# Version: 1.0
################################################################################

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
#VAR1="value1"
#VAR2="value2"

# Define functions
#function my_function() {
#    echo "Hello, world!"
#}

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Call a function
#my_function

# Do some other things...
#echo "Variable 1 is: $VAR1"
#echo "Variable 2 is: $VAR2"

# First, create the volume that Portainer Server will use to store its database:
docker volume create nessus_data

# Then, download and install the Portainer Server container:
docker run -itd \
-p 8000:8000 -p 9443:9443 \
--name nessus \
--restart=unless-stopped \
-v /var/run/docker.sock:/var/run/docker.sock \
-v nessus_data:/data \
tenable/nessus:latest-ubuntu

# Notify the user the script has completed.
echo "Script has finished!"