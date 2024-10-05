#!/bin/bash

# Ensure script is run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Updating system..."
sudo apt-get update && sudo apt-get upgrade -y

# Add NVIDIA's public key and Jetson apt repository
echo "Adding NVIDIA apt repository for Jetson Xavier NX..."
sudo apt-key adv --fetch-keys http://repo.download.nvidia.com/jetson/jetson-archive-keyring.gpg
sudo sh -c 'echo "deb https://repo.download.nvidia.com/jetson/common r32 main" > /etc/apt/sources.list.d/nvidia-l4t-apt-source.list'
sudo sh -c 'echo "deb https://repo.download.nvidia.com/jetson/t194 r32 main" >> /etc/apt/sources.list.d/nvidia-l4t-apt-source.list'

# Update apt cache
echo "Updating apt cache with new NVIDIA repository..."
sudo apt-get update

# Install JetPack components (CUDA, cuDNN, TensorRT, etc.)
echo "Installing JetPack components: CUDA, cuDNN, TensorRT, and other tools..."
sudo apt-get install -y nvidia-jetpack

# Optionally install individual components (CUDA, cuDNN, TensorRT, OpenCV, etc.)
echo "Installing individual JetPack components (CUDA, cuDNN, TensorRT, OpenCV)..."
sudo apt-get install -y nvidia-l4t-cuda
sudo apt-get install -y libcudnn8 libcudnn8-dev
sudo apt-get install -y nvidia-l4t-tensorrt
sudo apt-get install -y libopencv
sudo apt-get install -y nvidia-l4t-multimedia

# Reboot the system to apply changes
echo "JetPack, CUDA, and related components installed. Rebooting now..."
sudo reboot
