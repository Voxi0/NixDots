{ lib, ... }: {
  # Import Nix modules
  imports = [
    ./wofi ./ags ./mako.nix
  ];

  # Enable all applications by default
  enableWofi = lib.mkDefault true;
  enableAGS = lib.mkDefault true;
  enableMako = lib.mkDefault true;
}
