{ inputs, pkgs, username, ... }: {
  # Import Nix modules
  imports = [ ../../modules/home ];

	# Enable/Disable our custom Home Manager modules
  enableKitty = true;
  enableFirefox = true;
  enableGit = true;
  enableSpotify = true;
	enableMPD = true;
  enableNcmpcpp = true;
	enableDiscord = true;

	# Nix packages
	nixpkgs.config.allowUnfree = true;

	# Let Home Manager install and manage itself
	programs.home-manager.enable = true;

  # GTK and QT
  qt.enable = true;
  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  # XDG user directories
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # Manage user files
  home = {
		# User information
		inherit username;
		homeDirectory = "/home/${username}";
		stateVersion = "25.05";

    # Default packages that should be installed
    packages = with pkgs; [
      # Useful utilities
      unzip mpv wget curl

      # Applications
      obsidian
    ];

    # User files
    file = {
      # Wallpapers
      "Pictures/Wallpapers" = {
        source = ./../../modules/home/Pictures/Wallpapers;
        recursive = true;
      };
    };
  };
}
