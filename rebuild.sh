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

# Get the current NixOS generation
CURRENT_GEN=$(nix-env --list-generations --profile /nix/var/nix/profiles/system | tail -n 1 | awk '{print $1}')
NEXT_GEN=$((CURRENT_GEN + 1))
COMMIT_MSG="$(date '+%Y-%m-%d') - Attempting Build for gen: $NEXT_GEN"

# Ensure the user owns the repo before committing
chown -R "$(logname):$(id -gn logname)" "$GIT_REPO"

# Commit changes before rebuilding
sudo -u "$(logname)" bash <<EOF
    cd "$GIT_REPO"
    git add .
    git commit -m "$COMMIT_MSG"
EOF

# Copy the configuration files
rsync -av --delete "$CONFIG_SRC/" "$CONFIG_DST/"

# Rebuild NixOS
if deploy --remote-build --flake "$CONFIG_DST"; then
    echo "NixOS rebuild successful. Pushing changes to GitHub..."
    
    sudo -u "$(logname)" bash <<EOF
        cd "$GIT_REPO"
        git push
EOF
else
    echo "NixOS rebuild failed. Not pushing changes."
    exit 1
fi
