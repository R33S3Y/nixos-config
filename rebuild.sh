#!/bin/bash

set -e  # Exit immediately if a command fails

CONFIG_SRC="/home/reese/Desktop/nixos"
CONFIG_DST="/etc/nixos"
GIT_REPO="$CONFIG_SRC"
OBSIDIAN_HOST="192.168.1.248"   # Replace with obsidian IP or hostname
OBS_USER="reese"                # SSH user on obsidian

# Ensure the script is run with sudo
if [[ $EUID -ne 0 ]]; then
    echo "Please run as root (sudo $0)"
    exit 1
fi

# Get the current NixOS generation locally
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

# Copy the configuration files locally to diamond
rsync -av --delete "$CONFIG_SRC/" "$CONFIG_DST/"

# Rebuild NixOS locally (diamond)
if ! nixos-rebuild switch --flake $CONFIG_DST/#diamond --verbose; then
    echo "Local NixOS rebuild failed on diamond. Aborting."
    exit 1
fi

# Sync configuration files to obsidian
scp -r "$CONFIG_SRC"/* "${OBS_USER}@${OBSIDIAN_HOST}:/tmp/config_tmp/"

# Rebuild NixOS remotely (obsidian)
if ! ssh "${OBS_USER}@${OBSIDIAN_HOST}" "sudo -S rm -rf $CONFIG_DST/ && sudo -S mkdir $CONFIG_DST/ && sudo -S mv /tmp/config_tmp/* $CONFIG_DST/ && sudo -S nixos-rebuild switch --flake $CONFIG_DST/#obsidian"; then
    echo "Remote NixOS rebuild failed on obsidian. Aborting."
    exit 1
fi
 
echo "Both local and remote rebuild succeeded. Pushing changes to GitHub..."

# Push changes to GitHub
sudo -u "$(logname)" bash <<EOF
    cd "$GIT_REPO" 
    git push
EOF
