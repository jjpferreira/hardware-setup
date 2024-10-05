#!/bin/bash

# Ensure script is run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Setting Jetson Xavier NX to maximum performance mode..."

# Set power mode to maximum (15W mode, 6-core for Jetson Xavier NX)
echo "Setting power mode to MAXN (15W, 6-core)..."
sudo nvpmodel -m 0

# Enable jetson_clocks to maximize CPU, GPU, and memory frequencies
echo "Enabling jetson_clocks for maximum performance..."
sudo jetson_clocks

# Show clock frequencies to verify changes
echo "Displaying current clock frequencies:"
sudo jetson_clocks --show

# Optional: Increase swap file size for memory-intensive applications
SWAPFILE="/swapfile"
if [ ! -f "$SWAPFILE" ]; then
  echo "Creating a 8GB swap file..."
  sudo fallocate -l 8G /swapfile
  sudo chmod 600 /swapfile
  sudo mkswap /swapfile
  sudo swapon /swapfile
  echo "/swapfile none swap sw 0 0" | sudo tee -a /etc/fstab
  echo "Swap file created and enabled."
else
  echo "Swap file already exists."
fi

# Set swappiness to 10 to prefer RAM usage over swap
echo "Setting swappiness to 10 (prefers RAM usage over swap)..."
sudo sysctl vm.swappiness=10
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf

echo "Performance optimizations applied. Reboot for best results."

