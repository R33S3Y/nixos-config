#!/bin/bash

# Remove the existing /etc/nixos directory
echo "Removing existing /etc/nixos..."
sudo rm -rf /etc/nixos/

# Copy the nixos configuration from the desktop to /etc/nixos
echo "Copying nixos configuration to /etc/nixos..."
sudo cp -r ~/Desktop/nixos /etc/nixos

# Rebuild the system using NixOS
echo "Rebuilding NixOS configuration..."
sudo nixos-rebuild switch

# Rebuild and apply Home Manager configuration
echo "Rebuilding Home Manager configuration..."
home-manager switch -f /etc/nixos

echo "Setup complete!"
