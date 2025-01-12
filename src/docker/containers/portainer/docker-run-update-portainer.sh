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

# Exit immediately if a command exits with a non-zero status
set -e

# Main code
echo -e "Script is running..."
echo ""

LOG_FILE="./run.log" # Log file for errors and output messages.
# Defaults can be provided via environment files or command-line arguments; prioritize CLI if specified.
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
        if ! TAG=$(curl -s "https://api.github.com/repos/$3/$4/releases/latest"); then
            echo "TAG using curl is: $TAG" >> $LOG_FILE
            echo "Error: Failed to get releases information."  | tee -a "$LOG_FILE" >&2
            echo "" >> $LOG_FILE
            exit 1
        fi

        # Use jq to parse the JSON response and extract tag name if curl succeeded.
        if [ -n "$TAG" ]; then
            TAG_NAME=$(echo "$TAG" | jq -r '.tag_name' | sed 's/^v//') # Remove leading 'v' if present.
            echo "Info: curl TAG_NAME: $TAG_NAME" >> $LOG_FILE
        else
            echo "Error: Failed to parse release information." >&2
            exit 1
        fi

        # Output the tag name or an error message if not found.
        if [ -z "$TAG_NAME" ]; then
            echo "Error: No matching image tag found for $3/$4."  | tee -a "$LOG_FILE" >&2
            exit 1
        else            
            # If the command was successful, strip any remaining characters that are not part of the version number (e.g., '-alpine').
            VERSION=$(echo "$TAG_NAME" | sed 's/.*-//; s/-[a-z]*$//')
            echo "Info: Latest version using curl is: $VERSION" | tee -a "$LOG_FILE"
            echo "" >> $LOG_FILE
        fi
    }
    check_source "$@"

    pull_container(){
        echo ""
        echo "Pulling image for container: $6..."
        echo ""
        echo "ghcr.io/$3"/"$4":"$1" # Useful for debugging
        if ! docker pull "ghcr.io/${3}/${4}:${1}"; then
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
                --network=macvlan255 \
                --ip 10.0.255.148 \
                -p 3000:8080 \
                -v open-webui:/app/backend/data \
                --hostname open-webui \
                --name "$6" \
                -e OLLAMA_BASE_URL=http://ollama:11434 \
                -e TZ=America/New_York \
                --restart always \
                "ghcr.io/${3}/${4}:${1}"
        fi
    }
    pull_container "$@"
else
    echo "Info: No command-line arguments provided." | tee -a "$LOG_FILE"

    # Source the environment file if it exists and exit if it does not.
    ENV_FILE="./.env"
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
        if ! TAG=$(curl -s "https://api.github.com/repos/$OWNER/$GH_REPO/releases/latest"); then
            echo "Error: Failed to get releases information."  | tee -a "$LOG_FILE" >&2
            exit 1
        fi

        # Use jq to parse the JSON response and extract tag name if curl succeeded.
        if [ -n "$TAG" ]; then
            TAG_NAME=$(echo "$TAG" | jq -r '.tag_name' | sed 's/^v//') # Remove leading 'v' if present.
            echo "Info: curl TAG_NAME: $TAG_NAME" >> $LOG_FILE
        else
            echo "Error: Failed to parse release information." | tee -a "$LOG_FILE" >&2
            exit 1
        fi

        # Output the tag name or an error message if not found.
        if [ -z "$TAG_NAME" ]; then
            echo "Error: No matching image tag found for $OWNER/$REPO." | tee -a "$LOG_FILE" >&2
            exit 1
        else
            #echo "$TAG_NAME" # Uncomment for debugging
            # If the command was successful, strip any remaining characters that are not part of the version number (e.g., '-alpine').
            VERSION=$(echo "$TAG_NAME" | sed 's/.*-//; s/-[a-z]*$//')
            echo "Info: Latest version using curl is: $VERSION" | tee -a "$LOG_FILE"
            echo "" >> $LOG_FILE
        fi
    }
    check_source "$@"


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