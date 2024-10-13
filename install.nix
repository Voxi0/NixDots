{ pkgs ? import <nixpkgs> {} }: let
  diskoConfig = ./disko.nix;
in pkgs.mkShellNoCC {
  shellHook = ''
    # Ensure that the installer is being run from NixOS
    echo "Verifying that the installer is being run from NixOS"
    if ! [ -n "$(grep -i nixos < /etc/os-release)" ]; then
      echo "Verified this is NixOS."
      echo "This isn't NixOS or the distribution info isn't available"; exit 1;
    fi

    # Partition, format and mount disks using Disko - Disk configurations are defined in the 'disko.nix' file
    echo "Running Disko..."
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko "${diskoConfig}" || { echo "Disko failed"; exit 1; }

    # Move NixDots to the new system
    echo "Installing NixDots to new system..."
    sudo mkdir -p /mnt/etc/nixos
    if ! sudo cp -r ./* /mnt/etc/nixos/; then
      echo "Failed to install NixDots"; exit 1;
    fi

    # Generate 'hardware-configuration.nix' for the new system
    if ! sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix --root /mnt; then
      echo "Failed to generate 'hardware-configuration.nix' for new system"; exit 1;
    fi

    # Install NixOS
    echo "Installing NixOS..."
    if ! sudo nixos-install --no-root-passwd --no-channel-copy --flake /mnt/etc/nixos/#neo; then
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
