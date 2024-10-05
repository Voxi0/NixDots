{ lib, ... }: {
  # Import Nix modules
  imports = [
    ./wofi ./ags ./waybar.nix ./mako.nix
  ];

  # Enable all applications by default
  wofi.enable = lib.mkDefault true;
  ags.enable = lib.mkDefault true;
  waybar.enable = lib.mkDefault true;
  mako.enable = lib.mkDefault true;
}
