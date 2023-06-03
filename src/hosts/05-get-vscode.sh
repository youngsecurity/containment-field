#!/bin/sh

################################################################################
# Script Name: 05-get-vscode.sh
# Description: This script installs Microsoft VS Code.
# Author: Joseph Young <joe@youngsecurity.net>
# Created: 2023/06/03
# Version: 1.0
################################################################################

# Exit immediately if a command exits with a non-zero status
set -e

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Prompt the user for a choice
echo "Please choose an option:"
echo "1. VS Code"
echo "2. VS Code Insiders"
read -p "Enter your choice (1 or 2): " choice

# Check the user's choice
if [ "$choice" = "1" ]; then
    echo "You chose VS Code"
    # Add your desired actions for Option 1 here
    # Install the repository and key manually with the following:
    sudo apt-get install wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    # Then update the package cache and install the package using:
    sudo apt install apt-transport-https
    sudo apt update    
    sudo apt install code
elif [ "$choice" = "2" ]; then
    echo "You chose VS Code Insiders"
    # Add your desired actions for Option 2 here    
    # Install the repository and key manually with the following:
    sudo apt-get install wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    # Then update the package cache and install the package using:
    sudo apt install apt-transport-https
    sudo apt update    
    sudo apt install code-insiders
else
    echo "Invalid choice. Please choose either 1 or 2."
fi

# Notify the user the script has completed.
echo "Script has finished!"
