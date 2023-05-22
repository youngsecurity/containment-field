#!/bin/bash

################################################################################
# Script Name: sleep-and-read.sh
# Description: Here's an example of a Bash shell script that demonstrates the
#              use of synchronization, timeouts, and blocking mechanisms using
#              the `sleep` command and the `read` command.
# Author: Joseph Young <joe@youngsecurity.net>
# Created: 2023/05/22
# Version: 1.0
################################################################################

# Synchronization with sleep
echo "Starting the first task..."
sleep 5  # Simulating some processing time
echo "First task completed!"

# Timeout using sleep and condition check
echo "Starting the second task..."
sleep 2  # Simulating some processing time

timeout=8
elapsed_time=0
while true; do
    # Check if the condition is met
    if [[ "$elapsed_time" -ge "$timeout" ]]; then
        echo "Timeout occurred. Exiting the script."
        break
    fi

    # Check for completion condition
    if [ -f "complete.txt" ]; then
        echo "Second task completed!"
        break
    fi

    # Increment the elapsed time
    sleep 1
    elapsed_time=$((elapsed_time + 1))
done

# Blocking mechanism with user input
echo "Starting the third task..."
echo "Please press Enter to complete the task."
read -r
echo "Third task completed!"
