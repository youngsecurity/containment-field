#!/bin/sh

################################################################################
# Script Name: mv_overlay2.sh
# Description: This script will copy directories from /var/lib/docker/overlay2 
#              to a destination of the end users choice. 
# Author: Joseph Young <joe@youngsecurity.net>
# Created: 2023/06/15
# Version: 1.0
################################################################################

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
#VAR1="value1"
#VAR2="value2"
# Source directories
source_dirs=(
  "/var/lib/docker/overlay2/0fa7c71a0929701f612200e407d79f53554b647c7235ae6ff27bf6e637952c2f-init/diff"
  "/var/lib/docker/overlay2/ec02380ef34784a9da0c52a9cf3d4d9306a4f1c305edad28da858670e8ed7063/diff"
)
# Destination directory
destination_dir="/data/docker/overlay2"

# Define functions
function mv_overlay2() {

# Create the destination directory if it doesn't exist
mkdir -p "$destination_dir"

# Loop through each source directory
for dir in "${source_dirs[@]}"; do
  # Extract the directory name
  dir_name=$(basename "$dir")

  # Copy the directory recursively preserving permissions
  cp -Rp "$dir" "$destination_dir/$dir_name"  
done
}

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Call a function
mv_overlay2

# Do some other things...
#echo "Variable 1 is: $VAR1"
#echo "Variable 2 is: $VAR2"

# Notify the user the script has completed.
echo "Script has finished!"