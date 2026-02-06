# 🛠️ Universal LAMP Manager

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform: Linux](https://img.shields.io/badge/Platform-Linux-lightgrey.svg)](https://www.linux.org/)
[![Distros: Universal](https://img.shields.io/badge/Distros-Debian%20|%20Arch%20|%20Fedora-blue.svg)]()

A powerful, distro-agnostic CLI utility to manage your LAMP stack (Apache, MariaDB, PHP). Designed to work seamlessly across **Debian/Ubuntu**, **Arch Linux**, **Fedora**, and their derivatives like **Pop!_OS**, **CachyOS**, and **Zorin**.

---

## ✨ Features

* **Universal Compatibility:** Automatically detects your package manager (`apt`, `dnf`, `pacman`, `zypper`).
* **Smart Discovery:** Dynamically finds service names (e.g., `httpd` vs `apache2`) and configuration paths.
* **Live Status:** View real-time service status (● Running / ○ Stopped) directly from the menu.
* **One-Touch Management:** Start, stop, restart, and edit configs without memorizing systemctl commands.
* **Auto-Initialization:** Automatically handles MariaDB data directory setup (`mariadb-install-db`) on fresh installs.
* **Security Guard:** Includes a built-in check to ensure the script is run from the secure `/usr/local/bin/` path.

---

## 🚀 Installation

Install the manager and all necessary dependencies with a single command:

```bash
curl -sSL https://raw.githubusercontent.com/yuw1xx/lamp/refs/heads/main/scripts/install.sh | bash
```
**IMPORTANT!** This installer will detect your distribution, install the LAMP components if missing, and initialize the database. It requires sudo privileges.

## 🔧 Usage

Once installed, launch the manager from any terminal window:
```bash
lamp-manager
```
## 🖥️ Interface Overview

The manager provides a clean, stable numeric interface:
- **Main Menu:** Displays all detected services and their current live status.
- **Service Actions:** Choose a service to Start, Stop, Restart, or view a detailed Status log.
- **Config Editor:** Jump straight into the configuration file (apache2.conf, my.cnf, php.ini) using your system's default editor (nano/vim).

## 🗑️ Uninstallation

To remove the lamp-manager command and (optionally) purge the entire LAMP stack from your system:
Bash
```bash
curl -sSL https://raw.githubusercontent.com/yuw1xx/lamp/refs/heads/main/scripts/uninstall.sh | bash
```

## 📂 Project Structure

- *install.sh*: The bootstrap script that prepares your environment and sets up the global command.
- *uninstall.sh*: The clean-up utility to remove the tool and/or the LAMP stack.
- *lamp-manager*: The core logic (securely installed to /usr/local/bin/).

## 🤝 Contributing

This project aims to support as many Linux distributions as possible. If you encounter an issue on a specific distro, please feel free to open an Issue or submit a Pull Request!

**Developed with ❤️ for the Linux Community**
