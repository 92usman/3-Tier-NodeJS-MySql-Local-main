#!/bin/bash
# This script installs MySQL, sets up the database, creates tables,
# installs NodeJS dependencies for both client and server,
# builds the client, and starts both applications.

# Clone the project repository
git clone https://github.com/92usman/3-Tier-NodeJS-MySql-Local-main.git

# Update Ubuntu package list
sudo apt update

# Install MySQL Server
sudo apt install -y mysql-server

# Configure MySQL root user to use password authentication
sudo mysql <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
FLUSH PRIVILEGES;
EOF
# Above: Sets MySQL root password to "password" so NodeJS can log in.

# Create database and table
sudo mysql -u root -p"password" <<EOF
CREATE DATABASE IF NOT EXISTS test_db;
USE test_db;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    role ENUM('Admin', 'User') NOT NULL
);
EOF
# Above: Creates database + users table automatically without interaction.

# Move into client folder
cd ~/3-Tier-NodeJS-MySql-Local-main/client

# Install client dependencies
npm install

# Build client (Webpack)
npm run build

# Start client (runs React/Frontend)
npm start &
# The "&" allows the script to continue running the server.

# Move into server folder
cd ~/3-Tier-NodeJS-MySql-Local-main/server

# Install server dependencies
npm install

# Start server (NodeJS backend)
npm start
