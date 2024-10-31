#!/bin/bash

set -e # Enable immediate exit on error.

echo -e "Script is running..."
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
        echo "Error: Failed to parse release information." >&2
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

# Notify the user that script has finished.
echo "Script has finished!" | tee -a "$LOG_FILE"