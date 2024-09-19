{ pkgs ? import <nixpkgs> {} }: let
  DISKO_CONFIG="./disko.nix";
  MOUNT_POINT="/mnt";
in pkgs.mkShellNoCC {
  shellHook = ''
    # Run Disko to partition, format, and mount the disk
    echo "Running Disko to partition, format, and mount the disk..."
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko "$DISKO_CONFIG" || { echo "Disko failed"; exit 1; }

    # Generate default NixOS configuration and install NixOS
    echo "Generating NixOS configuration..."
    if ! nixos-generate-config --root ${MOUNT_POINT}; then
      echo "Failed to generate NixOS configuration"; exit 1;
    fi

    echo "Installing NixOS..."
    if ! nixos-install; then
      echo "NixOS installation failed"; exit 1;
    fi

    # Move dotfiles to the new system
    echo "Copying dotfiles to new system..."
    sudo cp -r ./* ./.git* ${MOUNT_POINT}/etc/nixos/ || { echo "Failed to copy dotfiles"; exit 1; }

    # Chroot into the new system and rebuild NixOS
    echo "Entering chroot environment and rebuilding NixOS..."
    if ! nixos-enter "${MOUNT_POINT}" -- bash -c "
      cd ${MOUNT_POINT}/etc/nixos
      sudo nix flake update --experimental-features 'nix-command flakes'
      sudo nixos-rebuild switch --flake /etc/nixos/#neo"; then
      echo "NixOS rebuild failed"; exit 1;
    fi

    # Installation complete
    echo "Installation complete! The system will power off now."
    echo "Unplug the installation media before powering on again!"
    read -p "Press Enter to power off..."
    poweroff
  '';
}
