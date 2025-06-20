{ inputs }: { lib, config, pkgs, ... }: {
  # Import Nix modules
  imports = [
    ./wofi ./swaync.nix ./wlogout.nix
  ];
}
