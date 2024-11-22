#!/bin/bash

# Prompt for Git user details
echo "Enter your Git username:"
read GIT_USERNAME
echo "Enter your Git email:"
read GIT_EMAIL

# Configure Git with the provided username and email
git config --global user.name "$GIT_USERNAME"
git config --global user.email "$GIT_EMAIL"

# Set default Git behavior
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global credential.helper store

echo "Git configuration set up successfully."

# Check if SSH key exists
SSH_KEY_PATH="$HOME/.ssh/id_rsa"
if [ -f "$SSH_KEY_PATH" ]; then
    echo "SSH key already exists at $SSH_KEY_PATH."
else
    echo "No SSH key found. Generating a new one..."
    ssh-keygen -t rsa -b 4096 -C "$GIT_EMAIL" -f "$SSH_KEY_PATH" -N ""
    echo "SSH key generated at $SSH_KEY_PATH."
fi

# Start the ssh-agent and add the key
eval "$(ssh-agent -s)"
ssh-add "$SSH_KEY_PATH"

# Display the public key
echo "Your SSH public key is:"
cat "$SSH_KEY_PATH.pub"

echo "Copy the above SSH key and add it to your Git hosting service (e.g., GitHub, GitLab)."

