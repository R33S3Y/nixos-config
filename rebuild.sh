#!/bin/bash

set -e  # Exit immediately if a command fails

CONFIG_SRC="/home/reese/Desktop/nixos"
CONFIG_DST="/etc/nixos"
GIT_REPO="$CONFIG_SRC"

# Ensure the script is run with sudo
if [[ $EUID -ne 0 ]]; then
    echo "Please run as root (sudo $0)"
    exit 1
fi

# Copy the configuration files
rsync -av --delete "$CONFIG_SRC/" "$CONFIG_DST/"

# Rebuild NixOS
if nixos-rebuild switch; then
    echo "NixOS rebuild successful. Pushing changes to GitHub..."
    
    # Get the current NixOS generation
    NIX_GENERATION=$(nix-env --list-generations --profile /nix/var/nix/profiles/system | tail -n 1 | awk '{print $1}')
    
    # Ensure the user owns the repo before pushing
    chown -R "$(logname):$(id -gn logname)" "$GIT_REPO"
    
    # Commit and push changes
    sudo -u "$(logname)" bash <<EOF
        cd "$GIT_REPO"
        git add .
        git commit -m "Updated NixOS configuration - Generation $NIX_GENERATION"
        git push
EOF
else
    echo "NixOS rebuild failed. Not pushing changes."
    exit 1
fi
