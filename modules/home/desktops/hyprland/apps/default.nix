{ lib, config, pkgs, ... }: {
  # Import Nix modules
  imports = [
    ./wofi ./quickshell.nix ./swaync.nix ./wlogout.nix
  ];
}
