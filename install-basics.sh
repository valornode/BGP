#!/bin/bash

set -e

echo "Updating package list..."
sudo apt update -y

echo "Installing dependencies..."
sudo apt install -y curl ca-certificates gnupg

echo "Installing bgpq4..."
git clone https://github.com/bgp/bgpq4.git /tmp/bgpq4
cd /tmp/bgpq4
make
sudo make install
cd ~
rm -rf /tmp/bgpq4

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

echo "Verifying installations..."
birdc show status
pathvector --version

echo "Installation complete!"
