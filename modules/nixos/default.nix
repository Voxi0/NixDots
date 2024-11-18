{ lib, ... }: {
  imports = [
    ./system.nix
    ./services.nix
    ./catppuccin.nix ./stylix.nix
    ./user.nix
    ./pipewire.nix
    ./networking.nix
    ./programs.nix
  ];

  # Default options
  enableStylix = lib.mkDefault true;
	enableCatppuccin = lib.mkDefault true;
}
