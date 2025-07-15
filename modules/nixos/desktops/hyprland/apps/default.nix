{ lib, config, pkgs, ... }: {
  # Import Nix modules
  imports = [
    ./playerctl.nix ./wofi ./quickshell.nix ./swaync.nix ./wlogout.nix
  ];
}
