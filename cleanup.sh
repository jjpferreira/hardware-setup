#!/bin/bash

# Cleanup Script for Linux

echo "Starting cleanup process..."

# Update and clean apt-get (Debian/Ubuntu)
if [ -x "$(command -v apt-get)" ]; then
  echo "Cleaning apt-get..."
  sudo apt-get update -y
  sudo apt-get autoclean -y
  sudo apt-get clean -y
  sudo apt-get autoremove -y
fi

# Clean Yum cache (CentOS/RHEL)
if [ -x "$(command -v yum)" ]; then
  echo "Cleaning Yum..."
  sudo yum clean all
fi

# Remove old kernels (Debian/Ubuntu)
if [ -x "$(command -v apt-get)" ]; then
  echo "Removing old kernels..."
  sudo apt-get autoremove --purge
fi

# Empty the Trash
echo "Emptying the Trash..."
rm -rf ~/.local/share/Trash/*

# Clear systemd journal logs
echo "Clearing systemd journal logs..."
sudo journalctl --vacuum-time=3d

# Clear user cache
echo "Clearing user cache..."
rm -rf ~/.cache/*

# Remove temporary files
echo "Removing temporary files..."
sudo rm -rf /tmp/*

echo "Cleanup completed successfully."
