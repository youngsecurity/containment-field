#!/bin/sh

################################################################################
# Script Name: add_quotes.sh
# Description: This script adds double quotes at the beginning and end of lines.
# Author: Joseph Young <joe@youngsecurity.net>
# Created: 2023/06/15
# Version: 1.0
################################################################################

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
#VAR1="value1"
#VAR2="value2"
# Input file
input_file="input.txt"
# Output file
output_file="output.txt"

# Define functions
add_quotes() {
# Process each line and add double quotes
  while IFS= read -r line; do
    quoted_line="\"$line\""
    echo "$quoted_line" >> "$output_file"
  done < "$input_file"
}

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Call a function
add_quotes

# Do some other things...
#echo "Variable 1 is: $VAR1"
#echo "Variable 2 is: $VAR2"

# Notify the user the script has completed.
echo "Script has finished!"