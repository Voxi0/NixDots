{ inputs, pkgs, ... }: {
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
    # Default packages that should be installed
    packages = with pkgs; [
      unzip			# To unzip zip files
			mpv				# Media player
			wget			# To download files
			curl			# To make HTTP requests
      obsidian	# Free and open source Markdown note taking application
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
