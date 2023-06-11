#!/bin/bash
#set -e
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