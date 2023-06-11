#!/bin/sh

################################################################################
# Script Name: run-steam.sh
# Description: This script executes Steam in a container.
# Author: Joseph Young <joe@youngsecurity.net>
# Created: 2023/06/10
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

sudo docker run -itd \
--shm-size=512m -p 6901:6901 \
--name steam \
--restart=unless-stopped \
-e VNC_PW=password \
kasmweb/steam:1.13.0

# Notify the user the script has completed.
echo "Script has finished!"