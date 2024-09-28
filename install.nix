{ pkgs ? import <nixpkgs> {} }: let
  diskoConfig = ./disko.nix;
  chrootCommands = ''
    # Set the password for the default user - Default username is mine of course :P
    passwd voxi0

    # Change the owner of '/etc/nixos' from root to the default user
    chown voxi0 /etc/nixos

    # Exit chroot
    exit
  '';
in pkgs.mkShellNoCC {
  shellHook = ''
    # Partition, format and mount disks using Disko - Disk configurations are defined in the 'disko.nix' file
    echo "Running Disko..."
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko "${diskoConfig}" || { echo "Disko failed"; exit 1; }

    # Move NixDots to the new system
    echo "Installing NixDots to new system..."
    sudo mkdir -p /mnt/etc/nixos
    if ! sudo cp -r ./* /mnt/etc/nixos/; then
      echo "Failed to install NixDots"; exit 1;
    fi

    # Install NixOS
    echo "Installing NixOS..."
    if ! sudo nixos-install --flake /mnt/etc/nixos/#neo; then
      echo "NixOS installation failed"; exit 1;
    fi

    # Chroot into the new installation to run extra commands
    echo "Entering chroot environment..."
    if ! sudo nixos-enter --command "bash ${chrootCommands}"; then
      echo "Failed to enter chroot environment"
    fi

    # Installation complete
    echo "Installation complete! The system will power off now."
    echo "Unplug the installation media before powering on again!"
    read -p "Press Enter to power off..."
    poweroff
  '';
}
