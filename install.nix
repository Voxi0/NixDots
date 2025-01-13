{ pkgs ? import <nixpkgs> {} }: let
  diskoConfig = ./disko.nix;
in pkgs.mkShellNoCC {
  shellHook = ''
    #!/bin/bash

    # Ensure that the installer is being run from NixOS
    echo "Verifying that the installer is being run from NixOS..."
    if ! [ -n "$(grep -i nixos < /etc/os-release)" ]; then
      echo "This isn't NixOS or the distro info isn't available"; exit 1;
    fi

		# Set host name (Which NixDots to install e.g. `Neo`), username and email
    while [[ -z "$hostname" ]]; do
			read -p "Enter hostname (Cannot be empty): " hostname
		done

		while [[ -z "$username" ]]; do
			read -p "Enter username (Cannot be empty): " username
		done
		sed -i "s/voxi0/$username/g" ./flake.nix ./chrootCommands.sh

		while [[ -z "$useremail" ]]; do
			read -p "Enter email (Cannot be empty - Used for configuring Git): " useremail
		done
		sed -i "s/alif200099@gmail.com/$useremail/g" ./modules/home/apps/git.nix

		# List available disks
		echo "Listing available disks..."
		disks=$(lsblk -d -o NAME,SIZE,MODEL | grep -v "loop" | grep -v "sr0")
		echo "$disks"

		# Prompt the user to choose the disk to install NixOS/NixDots to
		read -p "Enter the name of the disk to install NixDots to (e.g., /dev/sda): " installDisk

		# Ensure the user entered the full path for the disk e.g. "/dev/sda", "/dev/sdb"
		if [[ ! "$installDisk" =~ ^/dev/[^/]+$ ]]; then
			echo "Error: The disk must be specified with the full path (e.g., /dev/sda, /dev/sdb). Exiting."
			exit 1
		fi

		# Validate that the selected disk exists and is a block device
		if ! lsblk | grep -q "^$installDisk"; then
			echo "Error: The disk $installDisk does not exist or is not a block device. Exiting."
			exit 1
		fi

		# Ensure that the disk isn't a partition e.g. "/dev/sda1", "/dev/sdb1", etc.
		if [[ "$installDisk" =~ [0-9]$ ]]; then
			echo "Error: $installDisk appears to be a partition (e.g., /dev/sda1). Please select a whole disk (e.g., /dev/sda)."
			exit 1
		fi

		# Set the install disk in the flake
		sed -i "s|/dev/sda|$installDisk|g" ./flake.nix

    # Partition, format and mount disks using Disko - Disk configurations are defined in the 'disko.nix' file
    echo "Running Disko with the selected disk: $installDisk..."
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- -m disko --argstr device "$installDisk" "${diskoConfig}" || { echo "Disko failed"; exit 1; }

    # Move NixDots to the new system
    echo "Installing NixDots to new system..."
    sudo mkdir -p /mnt/etc/nixos
    if ! sudo cp -r ./* /mnt/etc/nixos/; then
      echo "Failed to install NixDots"; exit 1;
    fi

    # Generate 'hardware-configuration.nix' for the new system
    if ! sudo nixos-generate-config --show-hardware-config --no-filesystems --root /mnt > hardware-configuration.nix; then
      echo "Failed to generate 'hardware-configuration.nix' for new system"; exit 1;
    fi

    # Install NixOS
    echo "Installing NixOS..."
    if ! sudo nixos-install --no-channel-copy --flake /mnt/etc/nixos/$hostname; then
      echo "NixOS installation failed"; exit 1;
    fi

    # Installation complete
    echo "Installation complete! The system will power off now."
    echo "Unplug the installation media before powering on again!"
    read -p "Press Enter to power off..."
    poweroff
  '';
}
