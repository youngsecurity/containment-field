#!/bin/sh

#.SCRIPT NAME: Boilerplate for shell scripts
#.AUTHOR: Joseph Young <joe@youngsecurity.net>
#.DATE: 3/20/2023
#.DOCUMENTATION: 
#.DESCRIPTION: This is boilerplate for a shell script.
#.EXAMPLE: ./shellscript.sh <arguments>

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
VAR1="value1"
VAR2="value2"

# Define functions
function my_function() {
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
echo "Script has finished!"