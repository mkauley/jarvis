#!/bin/bash
set -e

GROUP="family"

if [ -z "$1" ]; then
    echo "Usage: $0 <username> [username2 ...]"
    exit 1
fi

for USER in "$@"; do
    # Create system user with no login shell and no home directory
    if ! id "$USER" &>/dev/null; then
        sudo useradd -M -s /usr/sbin/nologin "$USER"
        echo "Created user: $USER"
    else
        echo "User $USER already exists"
    fi

    # Add to family group
    sudo usermod -aG "$GROUP" "$USER"
    echo "Added $USER to $GROUP group"

    # Set Samba password
    echo "Set Samba password for $USER:"
    sudo smbpasswd -a "$USER"
    sudo smbpasswd -e "$USER"

    echo "Done: $USER can now access \\\\192.168.50.200\\jarvis"
done
