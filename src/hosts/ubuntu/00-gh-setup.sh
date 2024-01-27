#!/bin/bash
###################################################################
#
# Installing gh on Linux
# 
# https://github.com/cli/cli/blob/trunk/docs/install_linux.md
#
###################################################################

# Define the directory path
directory=~/github/

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

type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y