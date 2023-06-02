#!/bin/sh
###################################################################
# sudoers.d setup
# 
# Save this script as create_sudoers_file.sh and make it executable 
# using chmod +x create_sudoers_file.sh. Then, run the script as the 
# user for whom you want to create the sudoers file using sudo 
# ./create_sudoers_file.sh. The script will create a file in the 
# /etc/sudoers.d/ directory with the name of the user and the 
# necessary permissions.
#
# This will allow the logged in user to perform sudo without being 
# required to enter their password.

# Get the name of the current user
USERNAME=$(whoami)

# Create the sudoers.d directory if it doesn't exist
sudo mkdir -p /etc/sudoers.d

# Create a file in /etc/sudoers.d/ with the user's name
FILE="/etc/sudoers.d/$USERNAME"
sudo touch $FILE

# Add the necessary permissions to the file
sudo echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > $FILE

# Set the appropriate file permissions
sudo chmod 0440 $FILE

# Print a success message
echo "Sudoers file created for user $USERNAME at $FILE"





