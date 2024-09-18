{ pkgs, ... }: {
  # Import Nix modules
  imports = [
    ./apps
  ];

  # Base packages
  home.packages = with pkgs; [
    # Base
    hyprpaper qt6Packages.qt6ct libnotify

    # Utilities
    pamixer brightnessctl grim slurp feh udiskie
  ];

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    plugins = [ ];
    extraConfig = ''
      ${builtins.readFile ./hyprland.conf}
    '';
  };

  # Session Environment Variables
  home.sessionVariables = {
    # Required if Cursor Keeps Disappearing
    # WLR_NO_HARDWARE_CURSORS = "1";

    # Cursor Size
    XCURSOR_SIZE = "24";

    # GTK Config
    GTK_USE_PORTAL = "1";

    # Tell Apps to Use Wayland
    XDG_SESSION_TYPE = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    # ANKI_WAYLAND = "1";
    GDK_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
    # CLUTTER_BACKEND = "wayland";
  };
}
