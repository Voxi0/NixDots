{ pkgs ? import <nixpkgs> {} }: let
  diskoConfig = ./disko.nix;
in pkgs.mkShellNoCC {
  shellHook = ''
    # Ensure that the installer is being run from NixOS
    echo "Verifying that the installer is being run from NixOS..."
    if ! [ -n "$(grep -i nixos < /etc/os-release)" ]; then
      echo "This isn't NixOS or the distro info isn't available"; exit 1;
    fi

		# Set some stuff
		while [[ -z "$username" ]]; do
			read -p "Enter username (Cannot be empty): " username
		done
		sed -i "s/voxi0/$username/g" ./NixDots/flake.nix

		# List available disks
		echo "Listing available disks..."
		disks=$(lsblk -d -o NAME,SIZE,MODEL | grep -v "loop" | grep -v "sr0")
		echo "$disks"

		# Prompt for disk selection
		read -p "Enter the name of the disk to install NixDots to (e.g., /dev/sda): " installDisk

		# Validate that the selected disk exists
		if ! lsblk | grep -q "$installDisk"; then
			echo "Error: The disk $installDisk does not exist. Exiting."
			exit 1
		fi
		sed -i "s|/dev/sda|$installDisk|g" ./NixDots/flake.nix

    # Partition, format and mount disks using Disko - Disk configurations are defined in the 'disko.nix' file
    echo "Running Disko with the selected disk: $installDisk..."
		sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko --device "$installDisk" "${diskoConfig}" || { echo "Disko failed"; exit 1; }

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
    if ! sudo nixos-install --no-channel-copy --flake /mnt/etc/nixos/#neo; then
      echo "NixOS installation failed"; exit 1;
    fi

    # Chroot into the new installation to run extra commands
    echo "Entering chroot environment..."
    sudo cp ./chrootCommands.sh /mnt/
    if ! sudo nixos-enter -- bash -c './chrootCommands.sh'; then
      echo "Failed to enter chroot environment"; exit 1;
    fi
    sudo rm /mnt/chrootCommands.sh

    # Installation complete
    echo "Installation complete! The system will power off now."
    echo "Unplug the installation media before powering on again!"
    read -p "Press Enter to power off..."
    poweroff
  '';
}
