{ lib, config, inputs, pkgs, ... }: {
  # Import Nix modules
  imports = [
    inputs.hyprpanel.homeManagerModules.hyprpanel
  ];

  # Module options
  options = {
    enableHyprpanel = lib.mkEnableOption "Enables Hyprpanel";
  };

  # Configure Hyprpanel if it's enabled
  config = lib.mkIf config.enableHyprpanel {
    home.packages = with pkgs; [ hyprpanel ];
    programs.hyprpanel = {
      enable = true;
      systemd.enable = false;
      hyprland.enable = true;
      overwrite.enable = false;

      # Theme - Imports a specific theme from "./themes/*.json"
      # theme = "";

      # Configure bar layouts for monitors
      # layout = {
      #   "bar.layouts" = {
      #     "0" = {
      #       left = [ "dashboard" "workspaces" ];
      #       middle = [ "media" ];
      #       right = [ "volume" "systray" "notifications" ];
      #     };
      #   };
      # };

      # Settings
      settings = {
        theme = {
          bar.transparent = true;
          font = {
            name = "JetBrainsMono Nerd Font";
            size = "12px";
          };
        };

        bar = {
          launcher.autoDetectIcon = true;
          workspaces.show_icons = true;
        };

        menus.clock = {
          weather.unit = "metric";
          time = {
            military = false;
            hideSeconds = true;
          };
        };
      };
    };
  };
}
