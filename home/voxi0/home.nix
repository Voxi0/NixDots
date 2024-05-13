{ config, pkgs, ... }: {
  # Import Nix Modules
  imports = [ ./modules ];

  # Allow Unfree Software
  nixpkgs.config.allowUnfree = true;

  # User Home Config
  home = {
    # User Info
	username = "voxi0";
	homeDirectory = "/home/voxi0";
	stateVersion = "23.11";
  };

  # Programs Config
  programs = {
    # Let Home Manager Install and Manage Itself
	home-manager.enable = true;
  };

  # Enable XDG
  xdg.enable = true;
}
