#!/bin/bash

set -e  # Exit immediately if a command fails

CONFIG_SRC="/home/reese/Desktop/nixos"
CONFIG_DST="/etc/nixos"
GIT_REPO="$CONFIG_SRC"

if [[ $EUID -ne 0 ]]; then
    echo "Please run as root (sudo $0)"
    exit 1
fi

CURRENT_GEN=$(nix-env --list-generations --profile /nix/var/nix/profiles/system | tail -n 1 | awk '{print $1}')
NEXT_GEN=$((CURRENT_GEN + 1))
COMMIT_MSG="$(date '+%Y-%m-%d') - Attempting Build for gen: $NEXT_GEN"

# Fix ownership
chown -R "$(logname):$(id -gn logname)" "$GIT_REPO"

# Git commit
sudo -u "$(logname)" bash <<EOF
    cd "$GIT_REPO"
    git add .
    git commit -m "$COMMIT_MSG"
EOF

# Sync to system flake directory
rsync -av --delete "$CONFIG_SRC/" "$CONFIG_DST/"

# Deploy using deploy-rs
if deploy --remote-build "$CONFIG_DST"; then
    echo "Deploy successful. Pushing changes to GitHub..."
    sudo -u "$(logname)" bash <<EOF
        cd "$GIT_REPO"
        git push
EOF
else
    echo "Deploy failed. Not pushing changes."
    exit 1
fi

