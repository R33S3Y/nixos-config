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

GOOD="\033[94m"
OK="\033[35m"
BAD="\033[31m"
RESET="\033[0m"

# Ensure the script is run with sudo
if [[ $EUID -ne 0 ]]; then
    echo -e "${BAD}Please run as root (sudo $0)${RESET}"
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
    git commit -m "$COMMIT_MSG" || echo -e "${BAD}No changes to commit${RESET}"
EOF

# Copy the configuration files locally
rsync -av --delete "$CONFIG_SRC/" "$CONFIG_DST/"

# Rebuild NixOS locally (diamond)
if ! nixos-rebuild switch --flake "$CONFIG_DST/#diamond"; then
    echo -e "${BAD}Local NixOS rebuild failed on diamond. Aborting.${RESET}"
    exit 1
fi

# Loop through each remote host
for HOST in "${REMOTE_HOSTS[@]}"; do
    echo -e "${OK}Deploying to $HOST...${RESET}"

    ssh "$HOST" "rm -rf $CONFIG_DST && mkdir -p $CONFIG_DST"

    # Sync configuration files
    scp -r "$CONFIG_SRC"/* "$HOST:$CONFIG_DST/"

    # Extract just the hostname (after @ if present)
    HOSTNAME=$(echo "$HOST" | cut -d@ -f2)

    # Rebuild NixOS remotely
    if ! ssh "$HOST" "sudo -S nixos-rebuild switch --flake $CONFIG_DST/#$HOSTNAME"; then
        echo -e "${BAD}Remote NixOS rebuild failed on $HOSTNAME. Aborting.${RESET}"
        exit 1
    fi
done

echo -e "${GOOD}All rebuilds succeeded. Pushing changes to GitHub...${RESET}"

# Push changes to GitHub
sudo -u "$(logname)" bash <<EOF
    cd "$GIT_REPO"
    git push
EOF
