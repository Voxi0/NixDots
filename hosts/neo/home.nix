{ pkgs, ... }: {
  # Import Nix modules
  imports = [
    ./../../modules/home/desktops
    ./../../modules/home/apps
  ];

  # Required for non NixOS systems
  # targets.genericLinux.enable = true;

  # Files in the user home directory
  home.file = {
    # Wallpapers
    "Pictures/Wallpapers" = {
      source = ./../../modules/home/Pictures/Wallpapers;
      recursive = true;
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
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
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

  # Allows using bluetooth headset buttons to control media player
  services.mpris-proxy.enable = true;

  # Enable/Disable applications
  enableEmacs = false;
}
