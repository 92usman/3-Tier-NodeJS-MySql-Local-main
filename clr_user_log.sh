#!/bin/bash
# ============================================================
#  UNINSTALL SCRIPT FOR:
#  3-Tier-NodeJS-MySql-Local project
#  Removes: repo, MySQL DB + user, Node modules, build files
# ============================================================

echo "=== Removing project folder ==="
rm -rf ~/3-Tier-NodeJS-MySql-Local-main
# Deletes the entire cloned project directory.

echo "=== Stopping MySQL service ==="
sudo systemctl stop mysql
sudo systemctl disable mysql
# Stops MySQL and disables it from starting on boot.

echo "=== Dropping MySQL database and table ==="
sudo mysql -u root -p"password" <<EOF
DROP DATABASE IF EXISTS test_db;
DROP USER IF EXISTS 'root'@'localhost';
FLUSH PRIVILEGES;
EOF
# Removes the database and the root user you created for NodeJS.

echo "=== Removing MySQL Server ==="
sudo apt-get remove --purge -y mysql-server mysql-client mysql-common
sudo apt-get autoremove -y
sudo apt-get autoclean -y
sudo rm -rf /etc/mysql /var/lib/mysql
# Fully removes MySQL and all its data directories.

echo "=== Cleaning NodeJS dependencies (client + server) ==="
rm -rf ~/3-Tier-NodeJS-MySql-Local-main/client/node_modules
rm -rf ~/3-Tier-NodeJS-MySql-Local-main/server/node_modules
rm -f ~/3-Tier-NodeJS-MySql-Local-main/client/package-lock.json
rm -f ~/3-Tier-NodeJS-MySql-Local-main/server/package-lock.json
# Removes all installed npm packages and lock files.

echo "=== Uninstall complete ==="
