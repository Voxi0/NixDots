{ inputs, pkgs, ... }: {
  # Import Nix modules
  imports = [
    ./apps
  ];

  # Base packages
  home.packages = with pkgs; [
    # Base
    inputs.swww.packages.${pkgs.system}.swww qt6Packages.qt6ct libnotify

    # Utilities
    pamixer brightnessctl grim slurp feh udiskie
  ];

  # Stop Stylix from using Hyprpaper to set the wallpaper - We want to use SWWW for wallpapers instead
  stylix.targets = {
    hyprland.enable = false;  # Must be disabled in order to disable Hyprpaper without any conflicts
    hyprpaper.enable = false;
  };

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
		package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
			hyprbars
		];
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
