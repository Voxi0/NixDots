{ pkgs ? import<nixpkgs> {} }: pkgs.mkShellNoCC {
  shellHook = ''
    # Variables
    DISKO_CONFIG="./disko.nix"
    MOUNT_POINT="/mnt"

    # Run Disko to partition, format, and mount the disk
    echo "Running Disko to partition, format, and mount the disk..."
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko "$DISKO_CONFIG" || { echo "Disko failed"; exit 1; }

    # Chroot into the new system and rebuild NixOS
    echo "Entering chroot environment and rebuilding NixOS..."
    nixos-enter "$MOUNT_POINT" -- bash -c "nixos-rebuild switch" || { echo "NixOS rebuild failed"; exit 1; }

    # Exit chroot and clean up
    echo "Exiting chroot environment..."
    exit

    # Installation complete
    echo "NixDots installed successfully! System will be powered off now. Unplug installation media before powering on again!"
    read -p "Press Enter to power off..."
    poweroff
  '';
}
