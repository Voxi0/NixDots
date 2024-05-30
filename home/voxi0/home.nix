{ config, pkgs, ... }: {
  # Import Nix Modules
  imports = [ ./apps ./desktops/hyprland ];

  # Let Home Manager Install and Manage Itself
  programs.home-manager.enable = true;

  # User Home Config
  home = {
    # User Info
    username = "voxi0";
    homeDirectory = "/home/voxi0";
    stateVersion = "23.11";
  };

  # Allow Unfree Software
  nixpkgs.config.allowUnfree = true;

  # Enable Fontconfig and XDG
  fonts.fontconfig.enable = true;
  xdg.enable = true;

  # Packages
  home.packages = with pkgs; [
    # Apps
    firefox pavucontrol qemu
    
    # CLI Utilities
    neofetch imagemagick htop lf unzip wget curl

    # Dev Tools
    openssh python3 nasm gcc gnumake bear cmakeCurses rustup sass nodePackages_latest.nodejs libisoburn

    # Fonts
    (nerdfonts.override {fonts = [
      "JetBrainsMono"
    ];})
  ];

  # Set System Default Cursor Theme
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  # GTK
  gtk = {
    # Enable/Disable GTK
    enable = true;

    # Application Theme
    theme = {
      name = "Catppuccin-Mocha-Standard-Flamingo-Dark";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        accents = [ "flamingo" ];
        size = "standard";
        tweaks = [ "normal" ];
      };
    };

    # Icon Theme
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };

  # QT
  qt = {
    # Enable/Disable QT
    enable = true;

    # Platform Theme
    platformTheme.name = "qt6ct";

    # Style
    style = {
      name = "Catppuccin-Mocha-Standard-Flamingo-Dark";
      package = pkgs.catppuccin-kde.override {
        flavour = [ "mocha" ];
        accents = [ "flamingo" ];
      };
    };
  };
}
