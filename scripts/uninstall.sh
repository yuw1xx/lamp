#!/bin/bash

INSTALL_PATH="/usr/local/bin/lamp-manager"

echo "🗑️  Starting LAMP Manager Uninstaller..."

# 1. Remove the binary
if [ -f "$INSTALL_PATH" ]; then
    sudo rm "$INSTALL_PATH"
    echo "✅ Removed 'lamp-manager' command."
else
    echo "ℹ️  'lamp-manager' not found in $INSTALL_PATH. Skipping."
fi

# 2. Package Purge Logic
# We use /dev/tty to ensure 'read' works even if the script was piped from curl
echo -n "Clean up all LAMP packages (Apache, MariaDB, PHP)? (y/N): "
read -r choice < /dev/tty

if [[ "$choice" =~ ^[Yy]$ ]]; then
    echo "📦 Identifying package manager..."
    
    if command -v pacman &>/dev/null; then
        # Arch / CachyOS / Manjaro
        sudo pacman -Rs --noconfirm apache mariadb php-fpm
    elif command -v apt-get &>/dev/null; then
        # Debian / Ubuntu / Pop!_OS
        sudo apt purge -y apache2 mariadb-server php*
    elif command -v dnf &>/dev/null; then
        # Fedora / RHEL / CentOS
        sudo dnf remove -y httpd mariadb-server php-fpm
    else
        echo "❌ No supported package manager found. Please uninstall packages manually."
    fi
    echo "✨ LAMP stack components removed."
else
    echo "🛑 Package removal skipped. Only the manager tool was removed."
fi

echo "👋 Uninstallation complete."
