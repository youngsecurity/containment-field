#!/bin/bash

# .SCRIPT NAME: docker-run-oi.sh
# .AUTHOR: Joseph Young <joe@youngsecurity.net>
# .DATE: 02/21/2024
# .DOCUMENTATION: 
#   This script will perform the following tasks:
#       1. Pull the latest container image from the registry
#       2. Stop and delete the existing container
#       3. Start the Docker container and run it detached, interactive and allocate a pseudo-TTY
# .DESCRIPTION: This is a Docker run shell script to update a container.
# .EXAMPLE: ./docker-run-oi.sh <arguments>

# Exit immediately if a command exits with a non-zero status
set -e

# Main code
# Notify the user the script has started.
echo "Starting the script!"

#echo "Pulling the image..."
#echo "Building the image..."
#docker build -t openinterpreter . || { echo "Error building image"; exit 1; }

# Stopping the container
#echo "Stopping the container..."
#docker container stop open-interpreter >/dev/null 2>&1 || { echo "Error stopping container. Exiting."; exit 1; }

# Deleting existing container
#echo "Deleting existing container..."
#docker rm -f open-interpreter || { echo "Error deleting container. Exiting."; exit 1; }
#echo "Container removed!"


# Starting up the container...
echo "Starting up the container..."

docker run -dit \
	--network=macvlan255 \
	--ip 10.0.255.151 \
	--gpus=all \
	-v /:/files \
	--name open-interpreter \
	open-interpreter:latest interpreter \
	--model dolphin-mistral:latest \
	--api_base http://ollama:11434/v1

# Notify the user the script has completed.
echo "Script has finished!"