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
    firefox neofetch imagemagick htop lf unzip wget curl

    # Dev Tools
    openssh python3 gcc gnumake cmakeCurses rustup

    # Fonts
    (nerdfonts.override {fonts = [
      "JetBrainsMono"
    ];})
  ];
}
