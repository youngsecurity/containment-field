#!/bin/sh

################################################################################
# Script Name: backup.sh
# Description: This script performs a backup of specified files to a destination
#              directory.
# Author: Joseph Young <joe@youngsecurity.net>
# Created: 2023/05/22
# Version: 1.0
################################################################################

# Configuration
source_dir="/path/to/source"
destination_dir="/path/to/backup"
log_file="/path/to/log.txt"

# Main script logic
echo "Starting backup process..."

# Backup files
echo "Copying files from $source_dir to $destination_dir..."
cp -r "$source_dir" "$destination_dir"

# Logging
echo "Backup completed on $(date)" >> "$log_file"

echo "Backup process finished."