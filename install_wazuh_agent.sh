#!/bin/bash

# Define variables
WAZUH_MANAGER="192.168.30.194"
WAZUH_AGENT_VERSION="4.8.0-1"
WAZUH_AGENT_DEB="wazuh-agent_${WAZUH_AGENT_VERSION}_amd64.deb"

# Download Wazuh agent package
wget https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/${WAZUH_AGENT_DEB}

# Install Wazuh agent package
sudo WAZUH_MANAGER="${WAZUH_MANAGER}" dpkg -i ./${WAZUH_AGENT_DEB}

# Reload systemd manager configuration
sudo systemctl daemon-reload

# Enable and start Wazuh agent service
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent

# Clean up
rm -f ./${WAZUH_AGENT_DEB}

echo "Wazuh agent installation and setup complete."
