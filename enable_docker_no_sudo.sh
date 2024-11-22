#!/bin/bash

# Add the current user to the Docker group
sudo usermod -aG docker $USER

# Ensure the Docker socket has the correct group ownership and permissions
sudo chown root:docker /var/run/docker.sock
sudo chmod 660 /var/run/docker.sock

# Inform user to log out and back in for changes to take effect
echo "User added to the Docker group. Please log out and log back in (or restart) for the changes to take effect."

# Test Docker (optional, will only work after re-login or restart)
echo "After logging back in, test Docker with: docker run hello-world"

