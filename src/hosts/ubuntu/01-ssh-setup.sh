#!/bin/bash

###################################################################
# SSH & PKI Configuration
#
# You can save this script to a file, such as "add_ssh_key.sh", 
# make it executable with chmod +x add_ssh_key.sh, and then run it 
# with ./add_ssh_key.sh. Note that the user running the script must 
# have permission to access the private key file specified.
#
# Start the ssh-agent
eval "$(ssh-agent -s)"

# Check the SSH agent for keys
ssh-add -l

# If none exists, prompt the user for the location of their private SSH key
read -p "Enter the path to your private SSH key: " ssh_key_path

# Add the private key to the SSH agent
ssh-add $ssh_key_path

# Check the status of the SSH agent to confirm that the key was added
ssh-add -l

# Do not leave the private key on the system
sudo rm -f $ssh_key_path