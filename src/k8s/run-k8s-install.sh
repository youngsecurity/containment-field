#!/bin/sh

#
# .SCRIPT NAME: run-k8s-install.sh
# .AUTHOR: Joseph Young joe@youngsecurity.net
# .DATE: 3/20/2023
# .DOCUMENTATION: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
# .DESCRIPTION: This script installs k8s on Ubuntu 22
# .EXAMPLE: ./run-k8s-install.sh <arguments>

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables

# Define functions

# Main code
# Notify the user the script has started.
echo "Starting k8s installation..."

# Call a function

# Do some other things...
# Here is what each command does:
# 1. sudo apt-get update: Updates the local package index with the latest available versions of the software packages.
# 2. sudo apt upgrade -y: Upgrades the packages found to be outdated 
sudo apt update
sudo apt upgrade -y

# Disable Linux swap
# This is allegedly necessaryy because kubelet was not developed to understand how to work with system swap partitions
sudo swapoff -a
# Backup the fstab file before modifying it
cp /etc/fstab /etc/fstab.bak
# Use regex to comment out the line in fstab that begins with "swap.img"
sudo sed -i '/^.*swap.img/ s/^/#/' /etc/fstab
# Print a message to the user
echo "The line beginning with 'swap.img' has been commented out in /etc/fstab"

# Install the necessary packages that allow the system to securely communicate with web servers using the HTTPS protocol.
# Here is what each package does:
# 1. apt-transport-https: Allows the apt package manager to use HTTPS to communicate with repositories.
# 2. ca-certificates: Provides a list of trusted certificate authorities for the system to verify the authenticity of SSL/TLS certificates.
# 3. curl: A command-line tool for transferring data from or to a server using various protocols, including HTTP, HTTPS, FTP, etc.
sudo apt install -y apt-transport-https ca-certificates curl

# Download the Google Cloud public signing key
sudo curl -fsSLo /etc/apt/trusted.gpg.d/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

# Add the k8s apt repo
echo "deb [signed-by=/etc/apt/trusted.gpg.d/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Update apt package index, install kubelet, kubeadm, and kubectl, and pin their version
# Here is what each command does:
# 1. sudo apt update: Updates the local package index with the latest available versions of the software packages.
# 2. sudo apt install -y kubelet kubeadm kubectl: Installs the Kubernetes components on the system.
#       a. kubelet: The primary node agent that runs on each node in the cluster and manages the state of the pods.
#       b. kubeadm: The command-line tool for bootstrapping a Kubernetes cluster.
#       c. kubectl: The command-line tool for interacting with the Kubernetes API server.
#     The -y flag in this command instructs apt-get to answer "yes" to all prompts, which is useful for automating installation scripts.
# 3. sudo apt-mark hold kubelet kubeadm kubectl: This command marks the installed packages as "held", which prevents apt-get from automatically updating them in the future. This is important for ensuring that the installed versions of the Kubernetes components remain stable and compatible with each other.
# After running these commands, you should have a basic Kubernetes cluster installed on your system. However, you will still need to initialize the cluster with kubeadm init and join the nodes with kubeadm join commands to complete the setup.
sudo apt update
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Notify the user the script has completed.
echo "k8s installation finished!"