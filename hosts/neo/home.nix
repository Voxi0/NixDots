{ inputs, pkgs, ... }: {
  # Import Nix modules
  imports = [
		inputs.NixDotsHyprland.homeManagerModules.default
		../../modules/home
	];

	# Enable/Disable our custom Home Manager modules
  enableKitty = true;
  enableFirefox = true;
  enableGit = true;
  enableSpotify = true;
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
