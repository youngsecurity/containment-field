#!/bin/sh
#
# Install k8s on Ubuntu 22
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

# Update apt package index
sudo apt update

# Necessary packages that allow the system to securely communicate with web servers using the HTTPS protocol.
# Here is what each package does:
# apt-transport-https: Allows the apt package manager to use HTTPS to communicate with repositories.
# ca-certificates: Provides a list of trusted certificate authorities for the system to verify the authenticity of SSL/TLS certificates.
# curl: A command-line tool for transferring data from or to a server using various protocols, including HTTP, HTTPS, FTP, etc.
sudo apt get install -y apt-transport-https ca-certificates curl

# Download the Google Cloud public signing key
sudo curl -fsSLo /etc/apt/trusted.gpg.d/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

# Add the k8s apt repo
echo "deb [signed-by=/etc/apt/trusted.gpg.d/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Update apt package index, install kubelet, kubeadm, and kubectl, and pin their version
# Here is what each command does:
# 1. sudo apt-get update: Updates the local package index with the latest available versions of the software packages.
# 2. sudo apt-get install -y kubelet kubeadm kubectl: Installs the Kubernetes components on the system.
#       a. kubelet: The primary node agent that runs on each node in the cluster and manages the state of the pods.
#       b. kubeadm: The command-line tool for bootstrapping a Kubernetes cluster.
#       c. kubectl: The command-line tool for interacting with the Kubernetes API server.
#     The -y flag in this command instructs apt-get to answer "yes" to all prompts, which is useful for automating installation scripts.
# 3. sudo apt-mark hold kubelet kubeadm kubectl: This command marks the installed packages as "held", which prevents apt-get from automatically updating them in the future. This is important for ensuring that the installed versions of the Kubernetes components remain stable and compatible with each other.
# After running these commands, you should have a basic Kubernetes cluster installed on your system. However, you will still need to initialize the cluster with kubeadm init and join the nodes with kubeadm join commands to complete the setup.
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

