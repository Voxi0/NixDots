{ config, pkgs, ... }: {
  # Import Nix Modules
  imports = [
    ./desktops/hyprland ./apps
  ];

  # Enable Fontconfig
  fonts.fontconfig.enable = true;

  # Packages
  home.packages = with pkgs; [
    # Apps
    neofetch imagemagick htop

    # Fonts
    (nerdfonts.override {fonts = [
      "JetBrainsMono"
    ];})
  ];
}
