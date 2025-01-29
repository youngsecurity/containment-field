#!/bin/bash

################################################################################
# Script Name: mv_overlay2.sh
# Description: This script will copy directories from /var/lib/docker/overlay2 
#              to a destination of the end users choice. 
# Author: Joseph Young <joe@youngsecurity.net>
# Created: 2023/06/15
# Version: 1.0
################################################################################

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
#VAR1="value1"
#VAR2="value2"
# Source directories
source_dirs=(
  "/var/lib/docker/overlay2/0fa7c71a0929701f612200e407d79f53554b647c7235ae6ff27bf6e637952c2f-init"
  "/var/lib/docker/overlay2/0fa7c71a0929701f612200e407d79f53554b647c7235ae6ff27bf6e637952c2f"
  "/var/lib/docker/overlay2/ec02380ef34784a9da0c52a9cf3d4d9306a4f1c305edad28da858670e8ed7063"
  "/var/lib/docker/overlay2/7abe51d687826cab27c48945873f8b07844d7778279bd2c51b6090ff1efde89d"
  "/var/lib/docker/overlay2/d13372145baac096b9a72e147adce861539fff268864f466ca2955603c4eec19"
  "/var/lib/docker/overlay2/79b5e13653de8091681057b268b3e22140c980102a44b6f636b68400c1c702f6"
  "/var/lib/docker/overlay2/03ead422e11181d187e01022e0f87b71c612147d8af462bf3d30dfb2db67272f"
  "/var/lib/docker/overlay2/fbbc3d4e3e56571cfeb3cdb20931217359657dce4c530da3394d4239cd3e1bcb"
  "/var/lib/docker/overlay2/11e9afa5f4466edf177ffd5187e209e6a7060f08e1a30eab6ee86420aa7fc342"
  "/var/lib/docker/overlay2/063aa2a7d7edcd723d25599d6ba6dd19a6929d4f79234ec7232ad25630195763"
  "/var/lib/docker/overlay2/baa37f831c1c710e601efba92c3ce8aa25a396f03ca1f970fbb2152f74a155e3"
  "/var/lib/docker/overlay2/8b3e85655e85cf4d876442a708c1dbf53b64a5af807b9ebe78bbcc193514f924"
  "/var/lib/docker/overlay2/cb3e7d836545966dcb88756b891af2d2e0d41f68f3563eb295aa056de48324c5"
  "/var/lib/docker/overlay2/cf3d5b075d8a0d2cd72e91d4a60413a990ce367de2a5180f97af3576157ec599"
  "/var/lib/docker/overlay2/4c50036884ea56e0fc3094ba36e0862dd45709f14f24cf72f36642c463b52228"
  "/var/lib/docker/overlay2/41518651f2e9d6f4ddb2704dc2f2f30c67f275e53f9d0334287a288b63b36cc6"
  "/var/lib/docker/overlay2/6a2497c9eb39894dd8e68f999c863ae9eae17bb9e5417c6a07ea117f31973954"
  "/var/lib/docker/overlay2/5543dcc3d8ad113a561f11dd934de71b219963133aed470342bc8a3881603112"
  "/var/lib/docker/overlay2/708c588c5b7693d5cdb3fefcf271edeb084bf4a0a698303f196f7842aea79536"
  "/var/lib/docker/overlay2/3c6368f1ba8805c31c58a38aee4639f2ce961dcc7a774d68ff4ec83e5823f392"
  "/var/lib/docker/overlay2/9e075c2ba8272c92bca0a3e7db72ad1dc99a15a12e0d2bf553c4b58a29b27e97"
  "/var/lib/docker/overlay2/963b0e754679c32b05e1e83523ce4a72376f2446b01709f6d5e0e4f747ec4c6c"
  "/var/lib/docker/overlay2/662a1b0bb89f3bee2a92eb56e1fce51757b749191efb357d353d6ae6fd7bfe78"
  "/var/lib/docker/overlay2/200f563109448b85d2d16426cadd9988d59e70c7b851d7f31d09ee67a04ffd9b"
  "/var/lib/docker/overlay2/31fcf85087dc840acb30b3a307e4cf85054821eeb88cb45feb8745bc0f0e936d"
  "/var/lib/docker/overlay2/69b06d683932cc621da7c1c9d5f08f8cf23320954625547fd53c334e1f7e0a3a"
  "/var/lib/docker/overlay2/7adfd87bf4b6b38e7b0263fadc1a3c937d29a264972d33acb14788a6e80b24b0"
  "/var/lib/docker/overlay2/15aac69c7da50216b0a9412becf9632f7728adfdcbf0fe693ada5f56b1d08106"
  "/var/lib/docker/overlay2/0614777976be63899926f8e64cea84be271d11772c8c8063c07a8f4c1f933e57"
  "/var/lib/docker/overlay2/503bfc897ce085b16252ed1541e1ed490039f37334b54597ec616a93b8daec0e"
  "/var/lib/docker/overlay2/a38e64a9509ec3a23d63a54846d6e9af8294758d8143049905a33404309e62f3"
  "/var/lib/docker/overlay2/4ac954b3b89ca04d6fcc27bb7cc9e5b6826f13eef9601c06f15d5bd43746c0ff"
  "/var/lib/docker/overlay2/f427035c6f849967b4fb3f6b307290d7cd3cf9a6a3a44e5720f6ab78822024db"
  "/var/lib/docker/overlay2/a9e23f48abd3399f2f7fe443442b529a4cb1d987ed780b4fd5652f5d4da094b9"
)
# Destination directory
destination_dir="/data/docker/overlay2"

# Define functions
mv_overlay2() {

# Create the destination directory if it doesn't exist
mkdir -p "$destination_dir"

# Loop through each source directory
for dir in "${source_dirs[@]}"; do
  # Extract the directory name
  dir_name=$(basename "$dir")

  # Copy the directory recursively preserving permissions
  cp -Rp "$dir" "$destination_dir/$dir_name"  
done
}

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Call a function
mv_overlay2

# Do some other things...
#echo "Variable 1 is: $VAR1"
#echo "Variable 2 is: $VAR2"

# Notify the user the script has completed.
echo "Script has finished!"