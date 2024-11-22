#!/bin/bash

# Script to install Oracle VirtualBox on Ubuntu 22.04

# Update the system
echo "Updating the package list..."
sudo apt update -y
sudo apt upgrade -y

# Install prerequisites
echo "Installing prerequisites..."
sudo apt install -y wget gnupg software-properties-common

# Add Oracle VirtualBox repository key
echo "Adding Oracle VirtualBox repository key..."
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

# Add VirtualBox repository
echo "Adding VirtualBox repository..."
echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian jammy contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list

# Update package list again
echo "Updating package list..."
sudo apt update -y

# Install VirtualBox
echo "Installing VirtualBox..."
sudo apt install -y virtualbox-7.0

# Verify installation
echo "Verifying VirtualBox installation..."
if command -v virtualbox &> /dev/null
then
    echo "VirtualBox installed successfully!"
    virt

