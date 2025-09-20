#!/bin/bash

set -euo pipefail

CONFIG_SRC="/home/reese/Desktop/nixos"
CONFIG_DST="/tmp/config_current"
GIT_REPO="$CONFIG_SRC"

# List of remote hosts (can be just "host" or "user@host")
REMOTE_HOSTS=(
    "reese@obsidian"
    "reese@morganite"
)

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
    git commit -m "$COMMIT_MSG" || echo "No changes to commit"
EOF

# Copy the configuration files locally
rsync -av --delete "$CONFIG_SRC/" "$CONFIG_DST/"

# Rebuild NixOS locally (diamond)
if ! nixos-rebuild switch --flake "$CONFIG_DST/#diamond"; then
    echo "Local NixOS rebuild failed on diamond. Aborting."
    exit 1
fi

# Loop through each remote host
for HOST in "${REMOTE_HOSTS[@]}"; do
    echo "Deploying to $HOST..."

    ssh "$HOST" "rm -rf $CONFIG_DST && mkdir -p $CONFIG_DST"

    # Sync configuration files
    scp -r "$CONFIG_SRC"/* "$HOST:$CONFIG_DST/"

    # Extract just the hostname (after @ if present)
    HOSTNAME=$(echo "$HOST" | cut -d@ -f2)

    # Rebuild NixOS remotely
    if ! ssh "$HOST" "sudo -S nixos-rebuild switch --flake $CONFIG_DST/#$HOSTNAME"; then
        echo "Remote NixOS rebuild failed on $HOSTNAME. Aborting."
        exit 1
    fi
done

echo "All rebuilds succeeded. Pushing changes to GitHub..."

# Push changes to GitHub
sudo -u "$(logname)" bash <<EOF
    cd "$GIT_REPO"
    git push
EOF
