#!/bin/bash

# Update package list and install dependencies
sudo apt update
sudo apt install -y wget gpg apt-transport-https software-properties-common

# Import Microsoft GPG key
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/

# Add Visual Studio Code repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

# Update package list and install Visual Studio Code
sudo apt update
sudo apt install -y code

# Clean up GPG key file
rm -f packages.microsoft.gpg

# Confirm installation
echo "Visual Studio Code installation completed!"
code --version

