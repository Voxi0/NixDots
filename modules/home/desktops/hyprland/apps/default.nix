{ lib, ... }: {
  # Import Nix modules
  imports = [
    ./wofi ./hyprpanel.nix ./mako.nix
  ];

  # Enable all applications by default
  enableWofi = lib.mkDefault true;
  enableHyprpanel = lib.mkDefault true;
  enableMako = lib.mkDefault true;
}
