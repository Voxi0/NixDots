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

	# User Packages
    packages = with pkgs; [
      # Apps
      firefox

      # CLI Utilities
      neofetch htop lf unzip wget curl

      # Dev Tools
      openssh python3 gcc gnumake cmake rustup
    ];
  };

  # Programs Config
  programs = {
    # Let Home Manager Install and Manage Itself
	home-manager.enable = true;
  };

  # Enable XDG
  xdg.enable = true;
}
