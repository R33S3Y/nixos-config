#!/bin/bash

set -euo pipefail

CONFIG_SRC="/home/reese/Desktop/nixos"
CONFIG_DST="/tmp/config_current"
GIT_REPO="$CONFIG_SRC"

REMOTE_HOSTS=(
    "reese@obsidian"
    #"reese@morganite"
)

if [[ $EUID -ne 0 ]]; then
    echo "Please run as root (sudo $0)"
    exit 1
fi

CURRENT_GEN=$(nix-env --list-generations --profile /nix/var/nix/profiles/system | tail -n 1 | awk '{print $1}')
NEXT_GEN=$((CURRENT_GEN + 1))
COMMIT_MSG="$(date '+%Y-%m-%d') - Attempting Build for gen: $NEXT_GEN"

chown -R "$(logname):$(id -gn logname)" "$GIT_REPO"

sudo -u "$(logname)" bash <<EOF
    cd "$GIT_REPO"
    git add .
    git commit -m "$COMMIT_MSG" || echo "No changes to commit"
EOF

rsync -av --delete "$CONFIG_SRC/" "$CONFIG_DST/"

if ! nixos-rebuild switch --flake "$CONFIG_DST/#diamond"; then
    echo "Local NixOS rebuild failed on diamond. Aborting."
    exit 1
fi

# Function for deploying to a single host
deploy_host() {
    HOST="$1"
    HOSTNAME=$(echo "$HOST" | cut -d@ -f2)

    echo "[$HOSTNAME] Starting deployment..."

    ssh "$HOST" "rm -rf $CONFIG_DST && mkdir -p $CONFIG_DST" || {
        echo "[$HOSTNAME] Failed to prepare config dir"
        return 1
    }

    scp -r "$CONFIG_SRC"/* "$HOST:$CONFIG_DST/" || {
        echo "[$HOSTNAME] Failed to copy config"
        return 1
    }

    if ssh "$HOST" "sudo -S nixos-rebuild switch --flake $CONFIG_DST/#$HOSTNAME"; then
        echo "[$HOSTNAME] Rebuild succeeded"
    else
        echo "[$HOSTNAME] Rebuild failed"
        return 1
    fi
}

# Launch all hosts in parallel
pids=()
for HOST in "${REMOTE_HOSTS[@]}"; do
    deploy_host "$HOST" &
    pids+=($!)
done

# Wait for all and collect results
fail=0
for pid in "${pids[@]}"; do
    if ! wait "$pid"; then
        fail=1
    fi
done

if [[ $fail -eq 1 ]]; then
    echo "One or more remote rebuilds failed."
    exit 1
fi

echo "All rebuilds succeeded. Pushing changes to GitHub..."

sudo -u "$(logname)" bash <<EOF
    cd "$GIT_REPO"
    git push
EOF
