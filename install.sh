#!/bin/bash

# Variables
DISKO_CONFIG="./disko.nix"
NIXOS_REPO="https://github.com/Voxi0/NixDots"
MOUNT_POINT="/mnt"

# Step 1: Clone your NixOS configuration repository
echo "Cloning NixOS configuration repository..."
git clone "$NIXOS_REPO" "$MOUNT_POINT/etc/nixos/" || { echo "Failed to clone repository"; exit 1; }

# Step 2: Run Disko to partition, format, and mount the disk
echo "Running Disko to partition, format, and mount the disk..."
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko "$DISKO_CONFIG" || { echo "Disko failed"; exit 1; }

# Step 3: Activate swap space
echo "Activating swap space..."
swapon /dev/sda2 || { echo "Failed to activate swap space"; exit 1; } # Adjust /dev/sda2 to the actual swap partition if different

# Step 4: Chroot into the new system and rebuild NixOS
echo "Entering chroot environment and rebuilding NixOS..."
nixos-enter "$MOUNT_POINT" -- bash -c "nixos-rebuild switch" || { echo "NixOS rebuild failed"; exit 1; }

# Exit chroot and clean up
echo "Exiting chroot environment..."
exit

# Unmount filesystems if necessary
echo "Unmounting filesystems..."
umount "$MOUNT_POINT/boot" || { echo "Failed to unmount boot partition"; exit 1; }
umount "$MOUNT_POINT" || { echo "Failed to unmount root partition"; exit 1; }

# Step 5: Power off the system
echo "NixDots installed successfully! System will be powered off now. Unplug installation media before powering on again!"
read -p "Press Enter to power off..."
poweroff
