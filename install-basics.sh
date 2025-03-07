#!/bin/bash

set -e

echo "Updating package list..."
sudo apt update -y

echo "Installing dependencies..."
sudo apt install -y curl ca-certificates gnupg

echo "Installing Git..."
sudo apt install -y git

echo "Installing bgpq4..."
sudo apt update
sudo apt install -y snapd
sudo snap install snapd
sudo snap install bgpq4 --edge

echo "Installing BIRD..."
sudo apt install -y bird2

echo "Removing unneeded packages..."
apt-get autoremove

echo "Installing Pathvector..."
curl -fsSL https://deb.pathvector.io/key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/pathvector-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/pathvector-archive-keyring.gpg] https://deb.pathvector.io stable main" | sudo tee /etc/apt/sources.list.d/pathvector.list > /dev/null
sudo apt update -y
sudo apt install -y pathvector

echo "Enabling IPv4 forwarding..."
echo "net.ipv4.ip_forward=1" | sudo tee /etc/sysctl.d/99-ipv4-forwarding.conf > /dev/null
sudo sysctl -p /etc/sysctl.d/99-ipv4-forwarding.conf

sysctl -w net.ipv4.tcp_window_scaling=1

sysctl -w net.core.rmem_max=2097152

sysctl -w net.core.wmem_max=2097152

sysctl -w net.ipv4.tcp_rmem="4096 87380 2097152"

sysctl -w net.ipv4.tcp_wmem="4096 65536 2097152"

echo "Verifying installations..."
birdc show status
pathvector --version

echo "Installation complete!"
