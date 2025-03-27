# Shell Script to Automate New User Creation with Specific Permissions and Home Directory

#!/bin/bash

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root!" 
    exit 1
fi

# Get user details
read -p "Enter the username: " USERNAME
read -p "Enter the home directory (default: /home/$USERNAME): " HOME_DIR
read -p "Enter the shell (default: /bin/bash): " USER_SHELL
read -p "Enter additional groups (comma-separated, optional): " USER_GROUPS

# Set default values if not provided
HOME_DIR=${HOME_DIR:-/home/$USERNAME}
USER_SHELL=${USER_SHELL:-/bin/bash}

# Create the user with specified home directory and shell
useradd -m -d "$HOME_DIR" -s "$USER_SHELL" "$USERNAME"

# Check if the user was created successfully
if [[ $? -eq 0 ]]; then
    echo "User $USERNAME created successfully!"
else
    echo "Failed to create user $USERNAME."
    exit 1
fi

# Set home directory permissions
chmod 700 "$HOME_DIR"
chown "$USERNAME:$USERNAME" "$HOME_DIR"

# Add user to specified groups (if provided)
if [[ -n "$USER_GROUPS" ]]; then
    usermod -aG "$USER_GROUPS" "$USERNAME"
    echo "Added $USERNAME to groups: $USER_GROUPS"
fi

# Set a password for the user
passwd "$USERNAME"

# Confirmation message
echo "User $USERNAME has been created with home directory $HOME_DIR and shell $USER_SHELL."
