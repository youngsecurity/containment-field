#!/bin/bash
###################################################################
# sudoers.d setup
# 
# This will allow the logged in user to perform sudo without being 
# required to enter their password.
#
###################################################################

# Get the name of the current user
USERNAME=$(whoami)

# Create the sudoers.d directory if it doesn't exist
sudo mkdir -p /etc/sudoers.d

# Create a file in /etc/sudoers.d/ with the user's name
FILE="/etc/sudoers.d/$USERNAME"
sudo touch "$FILE"

# Add the necessary permissions to the file
sudo echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" | sudo tee "$FILE" > /dev/null

# Set the appropriate file permissions
sudo chmod 0440 "$FILE"

# Verify the sudoers file for any syntax errors
sudo visudo -cf "$FILE"

# Print a success message
echo "Sudoers file created for user $USERNAME at $FILE"





