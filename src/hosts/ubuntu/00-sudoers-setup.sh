#!/bin/bash
###################################################################
# sudoers.d setup
# 
# This will allow the logged in user to perform sudo without being 
# required to enter their password. 
#
###################################################################

# Get the name of the current user
current_user=$(whoami)

# Create the sudoers.d directory if it doesn't exist
sudo mkdir -p /etc/sudoers.d

# Create a sudoers_file in /etc/sudoers.d/ with the user's name
sudoers_file="/etc/sudoers.d/$current_user"
sudo touch "$sudoers_file"

# Add the necessary permissions to the sudoers_file
echo "$current_user ALL=(ALL) NOPASSWD:ALL" | sudo tee "$sudoers_file" > /dev/null

# Set the appropriate sudoers_file permissions
sudo chmod 0440 "$sudoers_file"

# Verify the sudoers sudoers_file for any syntax errors
sudo visudo -cf "$sudoers_file"

# Print a success message
echo "Sudoers sudoers_file created for user $current_user at $sudoers_file"