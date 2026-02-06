#!/bin/bash

INSTALL_PATH="/usr/local/bin/lamp-manager"

echo "🗑️ Starting Uninstallation..."

# 1. Remove the binary first
if [ -f "$INSTALL_PATH" ]; then
    sudo rm "$INSTALL_PATH"
    echo "✅ Removed 'lamp-manager' command from system path."
else
    echo "ℹ️  'lamp-manager' command not found in $INSTALL_PATH."
fi

# 2. Ask to purge the full stack
echo -n "Do you also want to uninstall Apache, MariaDB, and PHP? (y/N): "
read -r choice

if [[ "$choice" =~ ^[Yy]$ ]]; then
    echo "📦 Removing LAMP packages..."
    
    # Use command discovery to find the right package manager
    if command -v pacman &>/dev/null; then
        # Arch / CachyOS / Manjaro
        sudo pacman -Rs --noconfirm apache mariadb php-fpm
    elif command -v apt-get &>/dev/null; then
        # Debian / Ubuntu / Pop!_OS
        sudo apt purge -y apache2 mariadb-server php*
    elif command -v dnf &>/dev/null; then
        # Fedora / RHEL
        sudo dnf remove -y httpd mariadb-server php-fpm
    else
        echo "⚠️  Package manager not recognized. Please remove packages manually."
    fi
    
    echo "✨ LAMP stack components removed."
else
    echo "🛑 Skipping package removal. Only the manager was removed."
fi

echo "👋 Uninstallation complete."
