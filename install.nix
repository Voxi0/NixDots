{ pkgs ? import <nixpkgs> {} }: let
  diskoConfig = ./disko.nix;
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

    # Installation complete
    echo "Installation complete! The system will power off now."
    echo "Unplug the installation media before powering on again!"
    read -p "Press Enter to power off..."
    poweroff
  '';
}
