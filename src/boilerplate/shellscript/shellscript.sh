#!/bin/sh

################################################################################
# Script Name: shellscript.sh
# Description: This is boilerplate for a shell script.
# Author: Joseph Young <joe@youngsecurity.net>
# Created: 2023/10/06
# Version: 1.0
################################################################################

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
VAR1="value1"
VAR2="value2"

# Define functions
my_function() {
    echo "Hello, world!"
}

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Call a function
my_function

# Do some other things...
echo "Variable 1 is: $VAR1"
echo "Variable 2 is: $VAR2"

# Notify the user the script has completed.
#