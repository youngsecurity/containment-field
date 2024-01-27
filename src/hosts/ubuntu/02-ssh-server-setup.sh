#!/bin/bash

###################################################################
# SSH & PKI Configuration
#
# You can save this script to a file, such as "add_ssh_key.sh", 
# make it executable with chmod +x add_ssh_key.sh, and then run it 
# with ./add_ssh_key.sh. Note that the user running the script must 
# have permission to access the private key file specified.
#

# Define the directory path
directory=~/.ssh

# Check if the directory exists
if [ ! -d "$directory" ]; then
  # If it does not exist, create the directory
  echo "Directory $directory does not exist. Creating it now."
  mkdir -p "$directory"
  echo "Directory $directory has been created."
else
  # If it exists, print a message
  echo "Directory $directory already exists."
fi

# To install SSH on Ubuntu, you generally need to install the OpenSSH server package, which allows your system to accept SSH connections. Here's how you can do it:

# 1. **Open a Terminal:** Press `Ctrl` + `Alt` + `T` to open a terminal window.

# 2. **Update your package list:** Before installing new software, it's a good practice to update your package list to ensure you're getting the latest versions of packages and their dependencies.

sudo apt-get update

# 3. **Install OpenSSH Server:** Use the following command to install the OpenSSH server package:

sudo apt-get install openssh-server

# 4. **Verify SSH Service Status:** After installation, the SSH service should start automatically. You can check its status to ensure it's running properly with the command:

sudo systemctl status ssh

#    The output should indicate that the service is active (running). If it's not, you can start it manually with:

sudo systemctl start ssh

# 5. **(Optional) Configure SSH:** If you need to make any configuration changes, such as changing the default SSH port or restricting which users can log in, you can edit the SSH configuration file:

#sudo vim /etc/ssh/sshd_config

#    After making changes, save the file and exit the editor. Then, restart the SSH service to apply the changes:

#sudo systemctl restart ssh

# 6. **Firewall Configuration:** If you have `ufw` (Uncomplicated Firewall) enabled, you need to allow SSH connections through the firewall:

sudo ufw allow ssh

#    This command configures `ufw` to allow incoming SSH connections on the default port (22).

# 7. **Connect to Your Ubuntu System via SSH:** From another computer, you can connect to your Ubuntu system via SSH using the following command:

#ssh username@your_ubuntu_system_ip

#    Replace `username` with your username on the Ubuntu system and `your_ubuntu_system_ip` with the IP address of your Ubuntu system.

# By following these steps, you'll have SSH installed and running on your Ubuntu system, allowing secure remote access over the network.