#!/bin/bash

# Define variables
WAZUH_MANAGER="192.168.30.194"
WAZUH_AGENT_VERSION="4.8.0-1"
WAZUH_AGENT_DEB="wazuh-agent_${WAZUH_AGENT_VERSION}_amd64.deb"

# Function to handle errors
handle_error() {
    echo "An error occurred on line $1"
    exit 1
}

# Trap errors
trap 'handle_error $LINENO' ERR

# Download Wazuh agent package
echo "Downloading Wazuh agent..."
wget https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/${WAZUH_AGENT_DEB} -O /tmp/${WAZUH_AGENT_DEB} || handle_error $LINENO

# Install Wazuh agent package
echo "Installing Wazuh agent..."
sudo WAZUH_MANAGER="${WAZUH_MANAGER}" dpkg -i /tmp/${WAZUH_AGENT_DEB} || handle_error $LINENO

# Reload systemd manager configuration
echo "Reloading systemd manager configuration..."
sudo systemctl daemon-reload || handle_error $LINENO

# Enable and start Wazuh agent service
echo "Enabling and starting Wazuh agent service..."
sudo systemctl enable wazuh-agent || handle_error $LINENO
sudo systemctl start wazuh-agent || handle_error $LINENO

# Clean up
echo "Cleaning up..."
rm -f /tmp/${WAZUH_AGENT_DEB} || handle_error $LINENO

echo "Wazuh agent installation and setup complete."
