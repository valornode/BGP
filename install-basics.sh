#!/bin/bash

set -e
echo ""
echo ""
echo ""
echo ""
echo "Bird and Pathvector Installer Script!"
echo "Created by Brayden at Valor Node"
echo ""
echo "Thank you for installing my script, I hope it helps"
echo "you install and learn BGP, it's a great thing!"
echo ""
echo "Looking for a BGP VPS to learn BGP?"
echo "We offer IPv4/IPv6 subnets, BGP sessions, VMs"
echo "and much more!"
echo ""
echo "www.valornode.net"
sleep 10

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
curl https://repo.pathvector.io/pgp.asc > /usr/share/keyrings/pathvector.asc
echo "deb [signed-by=/usr/share/keyrings/pathvector.asc] https://repo.pathvector.io/apt/ stable main" > /etc/apt/sources.list.d/pathvector.list
apt update && apt install -y pathvector

echo "Setting up Pathvector configuration file..."
wget https://raw.githubusercontent.com/valornode/BGP/main/pathvector-config.sh -O pathvector-config.sh
chmod +x pathvector-config.sh
./pathvector-config.sh

echo "Enabling IPv4 forwarding..."
echo "net.ipv4.ip_forward=1" | sudo tee /etc/sysctl.d/99-ipv4-forwarding.conf > /dev/null
sudo sysctl -p /etc/sysctl.d/99-ipv4-forwarding.conf

sysctl -w net.ipv4.tcp_window_scaling=1

sysctl -w net.core.rmem_max=2097152

sysctl -w net.core.wmem_max=2097152

sysctl -w net.ipv4.tcp_rmem="4096 87380 2097152"

sysctl -w net.ipv4.tcp_wmem="4096 65536 2097152"

echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo "Verifying installations..."
echo ""
birdc show status
echo ""
echo ""
pathvector version

echo "Installation complete!"
