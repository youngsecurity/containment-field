#!/bin/sh

################################################################################
# Script Name: remove-kasm.sh
# Description: This script will remove Kasm Workspaces.
# Author: Joseph Young <joe@youngsecurity.net>
# Created: 2023/06/11
# Version: 1.0
################################################################################

# Exit immediately if a command exits with a non-zero status
#set -e

# Define variables
#VAR1="value1"
#VAR2="value2"

# Define functions
function remove_kasm() {
  # Stop all Kasm services.
  sudo /opt/kasm/current/bin/stop
  # Remove any Kasm session containers.
  output=$(sudo docker rm -f $(sudo docker container ls -qa --filter="label=kasm.kasmid") 2>&1)
  # If there are no session containers to remove, you will get an error that
  # “docker rm requires at least 1 argument”, which means that the command ran
  # successfully.
  
  # Check if the command produced the "docker rm requires at least 1 argument" error
  if [[ "$output" == *"docker rm requires at least 1 argument"* ]]; then
      echo "No session containers to remove."
  else
      echo "Command ran successfully."
  fi

  # Remove Kasm service containers.
  export KASM_UID=$(id kasm -u)
  export KASM_GID=$(id kasm -g)
  sudo -E docker compose -f /opt/kasm/current/docker/docker-compose.yaml rm

  # Remove the Kasm docker network.
  sudo docker network rm kasm_default_network

  # Remove the Kasm database docker volume
  sudo docker volume rm kasm_db_1.13.1

  # Remove the Kasm docker images.
  sudo docker rmi redis:5-alpine
  sudo docker rmi postgres:9.5-alpine
  sudo docker rmi kasmweb/nginx:latest
  sudo docker rmi kasmweb/share:1.13.1
  sudo docker rmi kasmweb/agent:1.13.1
  sudo docker rmi kasmweb/manager:1.13.1
  sudo docker rmi kasmweb/api:1.13.1

  sudo docker rmi $(sudo docker images --filter "label=com.kasmweb.image=true" -q)

  # Remove the Kasm installation directory structure.
  sudo rm -rf /opt/kasm

  # Remove the Kasm system user accounts.
  sudo deluser kasm_db
  sudo deluser kasm
}

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Call a function
remove_kasm

# Do some other things...
#echo "Variable 1 is: $VAR1"
#echo "Variable 2 is: $VAR2"

# Notify the user the script has completed.
echo "Script has finished!"