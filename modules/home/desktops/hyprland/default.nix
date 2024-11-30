{ inputs, pkgs, ... }: {
  # Import Nix modules
  imports = [
    ./apps
  ];

  # Base packages
  home.packages = with pkgs; [
    # Base
    hyprpolkitagent inputs.swww.packages.${pkgs.system}.swww libnotify
		libsForQt5.qt5.qtwayland kdePackages.qtwayland qt6Packages.qt6ct

    # Utilities
    pamixer brightnessctl grim slurp feh udiskie hyprwall hyprshade
  ];

  # Stop Stylix from using Hyprpaper to set the wallpaper - We want to use SWWW for wallpapers instead
  stylix.targets = {
    hyprland.enable = false;  # Must be disabled in order to disable Hyprpaper without any conflicts
    hyprpaper.enable = false;
  };

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
		xwayland.enable = true;
		systemd.enable = false;
		package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    plugins = with inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}; [
			hyprbars
		];
    extraConfig = ''
      ${builtins.readFile ./hyprland.conf}
    '';
  };

  # Session Environment Variables
  home.sessionVariables = {
    # Set to "1" if Cursor Keeps Disappearing
    WLR_NO_HARDWARE_CURSORS = "0";

		# Use Wayland
    GTK_USE_PORTAL = "1";
    XDG_SESSION_TYPE = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    GDK_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
  };
}
