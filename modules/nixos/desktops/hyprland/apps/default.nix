{ lib, config, pkgs, ... }: {
  # Import Nix modules
  imports = [
    ./wofi ./ags.nix ./swaync.nix ./wlogout.nix
  ];
}
