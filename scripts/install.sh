#!/bin/bash

REPO_URL="https://raw.githubusercontent.com/yuw1xx/lamp/refs/heads/main/scripts/lamp-manager"
TARGET="/usr/local/bin/lamp-manager"
EXPECTED_PATH="/usr/local/bin/lamp-manager"

if [[ "$(readlink -f "$0")" != "$EXPECTED_PATH" ]]; then
    echo -e "\033[0;31m❌ Error: LAMP Manager must be installed via the official installer.\033[0m"
    echo "Please use: curl -sSL https://raw.githubusercontent.com/yuw1xx/lamp/refs/heads/main/scripts/install.sh | bash"
    exit 1
fi

echo "🛡️ Starting LAMP Manager Installation..."

install_dependencies() {
    if command -v apt-get &>/dev/null; then
        sudo apt update && sudo apt install -y apache2 mariadb-server php-fpm curl fzf
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y httpd mariadb-server php-fpm curl fzf
    elif command -v pacman &>/dev/null; then
        sudo pacman -Syu --noconfirm apache mariadb php-fpm curl fzf
    else
        echo "❌ Unsupported Distribution. Please install LAMP components manually."
        exit 1
    fi
}

install_dependencies

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "⚙️  Initializing MariaDB..."
    sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
    sudo systemctl enable --now mariadb
else
    echo "ℹ️  MariaDB already initialized."
fi

echo "📥 Setting up lamp-manager..."
sudo curl -sSL "$REPO_URL" -o "$TARGET"
sudo chmod +x "$TARGET"

echo -e "\n✅ Installation Complete!"
echo "🚀 Type 'lamp-manager' to begin."
