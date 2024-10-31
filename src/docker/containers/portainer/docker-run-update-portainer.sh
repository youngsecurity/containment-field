#!/bin/bash

# .SCRIPT NAME: docker-run-update-container.sh
# .AUTHOR: Joseph Young <joe@youngsecurity.net>
# .DATE: 10/31/2024
# .DOCUMENTATION: 
#   This script will perform the following tasks:
#       1. Check and pull the latest version of the container image
#       2. Stop and remove the container
#       3. Start the container and run it detached, interactive and allocate a pseudo-TTY
# .DESCRIPTION: This is a Docker run shell script to update a container.
# .EXAMPLE: ./ddocker-run-update-container.sh <arguments>

set -e # Enable immediate exit on error.

echo -e "Script is running..." | tee -a "$LOG_FILE" >&2
echo ""

LOG_FILE="./run.log" # Log file for errors and output messages.
# Defaults can be provided via environment files or command-line arguments; prioritize CLI if specified.
DEFAULTS=(VERSION TAG_NAME OWNER REPO CONTAINERNAME)
for var in "${DEFAULTS[@]}"; do
    # shellcheck disable=SC2034  # Unused variables left for readability
    case $var in
        VERSION) DEFAULT_VAL=$1;;
        TAG_NAME) DEFAULT_VAL="${2:-}" ;;
        OWNER) DEFAULT_VAL="$3" ;;
        GH_REPO)  DEFAULT_VAL="$4" ;;
        DOCKER_REPO) DEFAULT_VAL="$5" ;;
        CONTAINERNAME) DEFAULT_VAL="$6" ;;        
    esac
done

# Source the environment file if it exists.
ENV_FILE=".env"
if [ -f "$ENV_FILE" ]; then
    # shellcheck source=.env
    source "$ENV_FILE"
fi

for var in "${DEFAULTS[@]}"; do
    eval "CURRENT_VAL=\$$var"
done

# Function to fetch and parse release information.
check_source() {
    if ! TAG=$(curl -s "https://api.github.com/repos/$OWNER/$GH_REPO/releases/latest"); then
        echo "Error: Failed to get releases information." | tee -a "$LOG_FILE" >&2
        exit 1
    fi
    
    # Use jq to parse the JSON response and extract tag name if curl succeeded.
    if [ -n "$TAG" ]; then
        TAG_NAME=$(echo "$TAG" | jq -r '.tag_name' | sed 's/^v//') # Remove leading 'v' if present.
    else
        echo "Error: Failed to parse release information."  | tee -a "$LOG_FILE" >&2
        exit 1
    fi
    
    if [ -z "$TAG_NAME" ]; then
        echo "Error: No matching image tag found for $OWNER/$REPO." | tee -a "$LOG_FILE" >&2
        exit 1
    else
        #echo "$TAG_NAME" # Uncomment for debugging
        # If the command was successful, strip any remaining characters that are not part of the version number (e.g., '-alpine').
        VERSION=$(echo "$TAG_NAME" | sed 's/.*-//; s/-[a-z]*$//')
        echo "The latest version is: $VERSION" | tee -a "$LOG_FILE"
    fi
}

check_source # Execute the function to check source information.

echo ""
echo "Pulling image for container: $CONTAINERNAME..."
if ! docker pull "${OWNER}/${DOCKER_REPO}:${VERSION}"; then
    echo "Error: Failed to pull Docker Hub image." | tee -a "$LOG_FILE" >&2
    exit 1
fi
echo ""

# Stopping the container
echo "Stopping the container..."
if ! docker container stop "$CONTAINERNAME"; then
    echo "Error: Failed to stop $CONTAINERNAME" | tee -a "$LOG_FILE" >&2
    #exit 1
fi
echo "Container stopped..."

# Delete existing Pi-hole
echo "Deleting existing container..."
if ! docker rm -f "$CONTAINERNAME"; then
    echo "Error: Failed to delete $CONTAINERNAME" | tee -a "$LOG_FILE" >&2
    #exit 1
fi
echo "Container removed..."

# Starting up the container...
echo "Starting up the container..."

docker run -itd \
    --gpus '"device=0,1"' \
    -p 8000:8000 -p 9443:9443 \
    --hostname "$CONTAINERNAME" \
    --name "$CONTAINERNAME" \
    --restart unless-stopped \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    -e TZ=America/New_York \
    "$OWNER"/"$DOCKER_REPO":"$VERSION"

# Notify the user that script has finished.
echo "Script has finished!" | tee -a "$LOG_FILE"