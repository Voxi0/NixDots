{ pkgs, ... }: {
  # Import Nix modules
  imports = [
    ./../../modules/home/desktops
    ./../../modules/home/apps
  ];

  # Required for non NixOS systems
  # targets.genericLinux.enable = true;

  # Allow unfree software - Must be defined here, not just "configuration.nix"
  nixpkgs.config.allowUnfree = true;

  # Home
  home = {
    # Files
    file = {
      "Pictures/Wallpapers" = {
        source = ./../../modules/home/Pictures/Wallpapers;
        recursive = true;
      };
    };
  };

  # GTK - Stylix already handles theme and cursor, so only the icon theme is set here
  gtk = {
    enable = true;

    # Icon theme
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    # Extra config for GTK3 and GTK4
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # QT - Ensure that we have proper QT styling
  qt = {
    enable = true;
    style.name = "adwaita-dark";
    platformTheme.name = "gtk3";
  };

  # XDG user directories
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # Enable/Disable applications
	enableFirefox = false;
  enableEmacs = false;
	enableZed = false;
}
