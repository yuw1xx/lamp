#!/bin/bash

if [ ! -t 0 ]; then
    IS_PIPED=true
else
    IS_PIPED=false
fi

REPO_URL="https://raw.githubusercontent.com/yuw1xx/lamp/main/scripts/lamp-manager.sh"
TARGET="/usr/local/bin/lamp-manager"

echo "🛡️  Starting Universal LAMP Installer..."

install_deps() {
    echo "📦 Checking dependencies..."
    if command -v apt-get &>/dev/null; then
        sudo apt update && sudo apt install -y apache2 mariadb-server php-fpm curl fzf
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y httpd mariadb-server php-fpm curl fzf
    elif command -v pacman &>/dev/null; then
        sudo pacman -Syu --noconfirm apache mariadb php-fpm curl fzf
    fi
}

install_deps

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "⚙️  Initializing MariaDB..."
    sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
    sudo systemctl enable --now mariadb
fi

echo "📥 Downloading core components..."
sudo curl -sSL "$REPO_URL" -o "$TARGET"
sudo chmod +x "$TARGET"

echo -e "\n✅ Installation Complete!"
if [ "$IS_PIPED" = true ]; then
    echo "🔗 Detected installation via remote curl."
fi
echo "🚀 Run the manager by typing: lamp-manager"
