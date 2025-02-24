#!/bin/bash

# Check if all the arguments are provided
if [ -z "$1" ]; then
  echo "ERROR: Invalid disk. Please enter a valid disk to install NixOS on e.g. `/dev/sda`"
  exit 1
fi
if [ -z "$2" ]; then
  echo "ERROR: Invalid hostname. Please enter a valid hostname e.g. `neo`"
  exit 1
fi

# Inform user that installation is starting
echo "Beginning NixOS installation with NixDots on disk `$1` with host `$2`..."

# Confirm disk selection (Optional, but a safety step)
echo "WARNING: All data on disk `$1` will be lost. Proceed? (y/n)"
read -n 1 -s response
if [[ ! "$response" =~ ^[Yy]$ ]]; then
  echo "Aborted installation"
  exit 1
fi

# Partition and format disks
echo "Partitioning and formatting the disk `$1`..."
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- -m disko --argstr device "$1" ./disko.nix

# Generate a new `hardware-configuration.nix` for the new system
echo "Generating hardware configuration..."
sudo nixos-generate-config --show-hardware-config --no-filesystems --root /mnt > hardware-configuration.nix

# Move NixDots to the new system - `/etc/nixos` by default but you can move it wherever you want after installing
echo "Copying NixDots to the new system..."
sudo mkdir -p /mnt/etc/nixos
sudo cp -r ./* /mnt/etc/nixos/

# Install NixOS - Replace `<hostname>` with the actual host to install e.g. `neo`
echo "Installing NixOS with the specified host `$2`..."
sudo nixos-install \
  --flake /mnt/etc/nixos/#"$2" \
  --option binary-caches https://hyprland.cachix.org \
  --option trusted-public-keys hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=

# Installation complete
echo "NixDots is installed successfully! Press any key to power off"
echo "IMPORTANT: Remove the installation media before rebooting"
read -n 1 -s
systemctl poweroff
