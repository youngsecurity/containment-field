#!/bin/bash
# .AUTHOR: Joseph Young <joe@youngsecurity.net>
# .DATE: 05/18/2024
# .DOCUMENTATION: 
#   This script will perform the following tasks:
#       1. Check and pull the latest version of the container image

# Exit immediately if a command exits with a non-zero status
set -e

# Main code
echo -e "Script is running..."
echo ""

# Variables
VERSION=""
TAG_NAME=""
OWNER="ollama"
REPO="ollama"
CONTAINERNAME="ollama-test"

check_source() {
    # Attempt to fetch the latest release tag name using curl and jq.
    if ! TAG=$(curl -s "https://api.github.com/repos/$OWNER/$REPO/releases/latest"); then
        echo "Error: Failed to get releases information." >&2
        exit 1
    fi

    # Use jq to parse the JSON response and extract tag name if curl succeeded.
    if [ -n "$TAG" ]; then
        TAG_NAME=$(echo "$TAG" | jq -r '.tag_name' | sed 's/^v//') # Remove leading 'v' if present.
    else
        echo "Error: Failed to parse release information." >&2
        exit 1
    fi

    # Output the tag name or an error message if not found.
    if [ -z "$TAG_NAME" ]; then
        echo "Error: No matching image tag found for $OWNER/$REPO." >&2
    else
        #echo "$TAG_NAME" # Uncomment for debugging
        # If the command was successful, strip any remaining characters that are not part of the version number (e.g., '-alpine').
        VERSION=$(echo "$TAG_NAME" | sed 's/.*-//; s/-[a-z]*$//')
        echo "The latest version is: $VERSION"
    fi
}

check_source

# Setup the container
echo ""
echo "Pulling image for container: $CONTAINERNAME..."
echo ""
#echo "$OWNER"/"$REPO":"$VERSION"
docker pull "$OWNER"/"$REPO":"$VERSION"
echo ""


# Notify the user the script has completed.
echo "Script has finished!"