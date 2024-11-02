{ pkgs, ... }: {
  # Import Nix modules
  imports = [
    ./../../hardware-configuration.nix
    ./../../modules/nixos
  ];

  # Nix/Nixpkgs settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Boot
  boot.kernelPackages = pkgs.linuxPackages_zen;
}
