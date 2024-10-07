{ lib, ... }: {
  # Import Nix modules
  imports = [
    ./wofi ./ags ./waybar.nix ./mako.nix
  ];

  # Enable all applications by default
  enableWofi = lib.mkDefault true;
  enableAGS = lib.mkDefault true;
  enableWaybar = lib.mkDefault true;
  enableMako = lib.mkDefault true;
}
