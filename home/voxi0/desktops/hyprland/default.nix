{ config, pkgs, ... }: {
  # Import Nix Modules
  imports = [
    ./apps/kitty.nix ./apps/fish.nix ./apps/waybar.nix ./apps/rofi/rofi.nix ./apps/mako.nix
  ];

  # Packages
  home.packages = with pkgs; [
    # Base
    hyprpaper qt6Packages.qt6ct libnotify

    # Utilities
    pamixer brightnessctl grim slurp feh udiskie
  ];

  # Hyprland Config
  wayland.windowManager.hyprland = {
    # Let Home Manager Install and Manage Hyprland
    enable = true;

    # Enable/Disable Nvidia Patches and XWayland
    xwayland.enable = true;

    # Import Hyprland Config File
    extraConfig = ''${builtins.readFile ./hypr/hyprland.conf}'';
  };

  # Dotfiles
  home.file.".config/hypr/hyprpaper.conf".source = ./hypr/hyprpaper.conf;
  home.file."Pictures/".source = ./hypr/Pictures;

  # Session Environment Variables
  home.sessionVariables = {
    # Required if Cursor Keeps Disappearing
    # WLR_NO_HARDWARE_CURSORS = "1";

    # Cursor Size
    XCURSOR_SIZE = "24";

    # GTK Config
    GTK_USE_PORTAL = "1";

    # QT Config
    QT_QPA_PLATFORMTHEME = "qt6ct";

    # Tell Apps to Use Wayland
    # NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    ANKI_WAYLAND = "1";
    GDK_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
  };
}
