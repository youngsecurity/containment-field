#!/bin/bash

# .SCRIPT NAME: docker-run-update-"$container".sh
# .AUTHOR: Joseph Young <joe@youngsecurity.net>
# .DATE: 01/12/2025
# .DOCUMENTATION: 
#   This script will perform the following tasks:
#       1. Check and pull the latest version of the container image from GitHub
#       2. Stop and remove the Docker container
#       3. Start the Docker container and run it detached, interactive and allocate a pseudo-TTY
# .DESCRIPTION: This is a Docker run shell script to update a container.
# .EXAMPLE: ./docker-run-update-"$container".sh <arguments>

# Exit immediately if a command exits with a non-zero status
set -e

# Main code
echo -e "Script is running..."
echo ""

LOG_FILE="./run.log" # Log file for errors and output messages.

# Source the environment file if it exists and exit if it does not.
ENV_FILE="./.env"

# Defaults can be provided via environment file, command-line arguments, or hardcoded; prioritize CLI if specified.
DEFAULTS=(VERSION TAG_NAME OWNER GH_REPO DOCKER_REPO CONTAINERNAME)
for var in "${DEFAULTS[@]}"; do
    # shellcheck disable=SC2034  # Unused variables left for readability
    case $var in
        VERSION) DEFAULT_VAL=$1 ;;
        TAG_NAME) DEFAULT_VAL="${2:-}" ;;
        OWNER) DEFAULT_VAL="$3" ;;
        GH_REPO)  DEFAULT_VAL="$4" ;;
        DOCKER_REPO) DEFAULT_VAL="$5" ;;
        CONTAINERNAME) DEFAULT_VAL="$6" ;;        
    esac
done

for var in "${DEFAULTS[@]}"; do
    eval "CURRENT_VAL=\$$var"
done

# Check, log & debug arguments & variables
if [ $# -gt 0 ]; then # if CLI arguments are provided
    echo "" | tee -a "$LOG_FILE"
    echo "Info: Command-line arguments were provided." | tee -a "$LOG_FILE"
    echo "Info: Command: $0" >> $LOG_FILE
    #VERSION=""
    echo "Info: CLI VERSION: $1" >> $LOG_FILE
    #TAG_NAME=""
    echo "Info: CLI TAG_NAME: $2" >> $LOG_FILE
    #OWNER=""
    echo "Info: CLI OWNER: $3" >> $LOG_FILE
    #REPO=""
    echo "Info: CLI GH_REPO: $4" >> $LOG_FILE
    #DOCKER_REPO=""
    echo "Info: CLI DOCKER_REPO: $5" >> $LOG_FILE
    #CONTAINERNAME=""
    echo "Info: CLI CONTAINERNAME: $6" >> $LOG_FILE

    check_source() {
        # Attempt to fetch the latest release tag name using curl and jq.
        if ! TAG=$(curl -s "https://hub.docker.com/v2/repositories/$3/$5/tags?page_size=100" | jq -r '.results[].name' | grep -E '^v?[0-9]+\.[0-9]+\.[0-9]+$' | sed 's/^v//' | sort -V | tail -n1); then
            echo "TAG using curl is: $TAG" >> $LOG_FILE # useful for debugging
            echo "Error: Failed to get releases information."  | tee -a "$LOG_FILE" >&2
            echo "" >> $LOG_FILE
            exit 1
        fi
    }
    check_source "$@"

    check_exists() {
        echo "Latest TAG using curl is: $TAG" >> $LOG_FILE # useful for debugging
        # Attempt to use Docker commands and check if the container exists already.
        if docker ps -a --filter "name=$6" --filter "ancestor=${3}/${5}:${1}" --format '{{.Names}}' | grep -w "$6" > /dev/null; then    
            echo "Container '$6' with image '${5}:${1}' already exists. Exiting..." | tee -a "$LOG_FILE"           
            echo "" | tee -a "$LOG_FILE"
            exit 0
        else
            echo "Container '$6' with image '${3}/${5}:${1}' does not exist." | tee -a "$LOG_FILE"
            echo "" | tee -a "$LOG_FILE"
        fi
    }
    check_exists "$@"

    pull_container(){
        echo ""
        echo "Pulling image for container: $6..."
        echo ""
        echo "Registry: $3/$5:$1"  | tee -a "$LOG_FILE" >&2 # Useful for debugging
        if ! docker pull "${3}/${5}:${1}"; then
            echo "Error: Failed to pull Docker image." | tee -a "$LOG_FILE" >&2
            echo "" >> $LOG_FILE
            exit 1
        else
            echo "Stopping the container..."
            
            docker container stop "$6"

            echo "Deleting existing container..."
            docker rm -f "$6"
            echo "$6 removed!"      
            echo "Starting up $6..."            

            docker run -itd \
                --gpus '"device=GPU-fcc90235-d4c3-65e4-f064-446367f1cb5c"' \
                -p 8000:8000 -p 9443:9443 \
                --hostname "$6" \
                --name "$6" \
                -v /var/run/docker.sock:/var/run/docker.sock \
                -v portainer_data:/data \
                -e TZ=America/New_York \
                --restart=unless-stopped \
                "${3}/${5}:${1}"
        fi
    }
    pull_container "$@"
else
    echo "Info: No command-line arguments provided." | tee -a "$LOG_FILE"

    if [ -f "$ENV_FILE" ]; then
        # shellcheck source=.env
        source "$ENV_FILE"
    else
        echo "Info: No .env loaded" | tee -a "$LOG_FILE"
        echo "Error: Variables must be provided." | tee -a "$LOG_FILE"
        echo "" >> $LOG_FILE
        echo "Script has finished with errors, check \"run.log\"!"    
        exit 1
    fi

    check_source() {
        # Attempt to fetch the latest release tag name using curl and jq.
        if ! TAG=$(curl -s "https://hub.docker.com/v2/repositories/$OWNER/$DOCKER_REPO/tags?page_size=100" | jq -r '.results[].name' | grep -E '^v?[0-9]+\.[0-9]+\.[0-9]+$' | sed 's/^v//' | sort -V | tail -n1); then
            echo "TAG using curl is: $TAG" >> $LOG_FILE # useful for debugging
            echo "Error: Failed to get releases information."  | tee -a "$LOG_FILE" >&2
            echo "" >> $LOG_FILE
            exit 1
        fi
    }
    check_source "$@"

    check_exists() {
        echo "Latest TAG using curl is: $TAG" >> $LOG_FILE # useful for debugging
        # Attempt to use Docker commands and check if the container exists already.
        if docker ps -a --filter "name=$CONTAINERNAME" --filter "ancestor=$OWNER/$DOCKER_REPO:$TAG" --format '{{.Names}}' | grep -w "$6" > /dev/null; then    
            echo "Container '$CONTAINERNAME' with image '$DOCKER_REPO:$TAG' already exists. Exiting..." | tee -a "$LOG_FILE"           
            echo "" | tee -a "$LOG_FILE"
            exit 0
        else
            echo "Container '$CONTAINERNAME' with image '$OWNER/$DOCKER_REPO:$TAG' does not exist." | tee -a "$LOG_FILE"
            echo "" | tee -a "$LOG_FILE"
        fi
    }
    check_exists "$@"

    pull_container(){
        echo ""
        echo "Pulling image for container: $CONTAINERNAME..."
        echo ""
        echo "From: $OWNER/$DOCKER_REPO:$TAG" # Useful for debugging
        if ! docker pull "${3}/${5}:${1}"; then
            echo "Error: Failed to pull Docker image." | tee -a "$LOG_FILE" >&2
            echo "" >> $LOG_FILE
            exit 1
        else
            echo "Stopping the container..."            
            docker container stop "$CONTAINERNAME"
            echo "Deleting existing container..."
            docker rm -f "$CONTAINERNAME"
            echo "$CONTAINERNAME removed!"
            echo "Starting up $CONTAINERNAME..."
            docker run -itd \
                --gpus '"device=GPU-fcc90235-d4c3-65e4-f064-446367f1cb5c"' \
                -p 8000:8000 -p 9443:9443 \
                --hostname "$CONTAINERNAME" \
                --name "$CONTAINERNAME" \
                -v /var/run/docker.sock:/var/run/docker.sock \
                -v portainer_data:/data \
                -e TZ=America/New_York \
                --restart=unless-stopped \
                "$OWNER/$DOCKER_REPO:$TAG"
        fi
    }
    pull_container "$@"

echo ""
fi

# Notify the user the script has completed.
echo "Script has finished!" | tee -a "$LOG_FILE"