#!/bin/bash

INSTALL_PATH="/usr/local/bin/lamp-manager"

# Remove binary
if [ -f "$INSTALL_PATH" ]; then
    sudo rm "$INSTALL_PATH"
    echo "🗑️ Removed lamp-manager command."
fi

# Purge Stack
echo -n "Clean up all LAMP packages? (y/N): "
read -r choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
    if command -v apt-get &>/dev/null; then
        sudo apt purge -y apache2 mariadb-server php*
    elif command -v dnf &>/dev/null; then
        sudo dnf remove -y httpd mariadb-server php-fpm
    elif command -v pacman &>/dev/null; then
        sudo pacman -Rs --noconfirm apache mariadb php-fpm
    fi
    echo "✨ Stack uninstalled."
fi
