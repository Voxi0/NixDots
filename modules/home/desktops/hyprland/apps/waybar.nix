{ lib, config, pkgs, ... }: {
  # Module options
  options = {
    waybar.enable = lib.mkEnableOption true;
  };

  # Configure Waybar if it's enabled
  config = lib.mkIf config.waybar.enable {
    # Don't let Stylix style Waybar
    stylix.targets.waybar.enable = false;

    # Waybar configuration
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        mainBar = {
          # Position and layer
          layer = "top";
          position = "top";
          height = 40;

          # Modules
          modules-left = [ "hyprland/workspaces" ];
          modules-center = [ "clock" ];
          modules-right = [ "network" "temperature" "pulseaudio" "backlight" "battery" "tray" ];

          # Clock config
          "clock" = {
            format = "{:%H:%M}";
            format-alt = "{:%A %d %B %Y}";
          };

          # Temperature config
          "temperature" = {
            format = "{temperatureC}°C ";
          };

          # Pulseaudio config
          "pulseaudio" = {
            format = "{volume}% 󰕾";
          };

          # Backlight config
          "backlight" = {
            format = "{percent}% 󰃞";
          };

          # Internet config
          "network" = {
            format-wifi = "{essid} ({signalStrength}%)";
          };
          
          # Battery config
          "battery" = {
            format = "󰁹 {capacity}%";
          };
        };
      };
      style = ''
        * {
          /* Font Config */
          font-family: "JetBrainsMono Nerd Font";
          font-style: normal;
          font-size: 14px;

          /* Border Config */
          border: none;
          border-radius: 4px;
        }

        window#waybar {
          /* Color Config */
          background-color: rgba(0, 0, 0, 0);

          /* Border Config */
          border-radius: 0px;
        }

        #workspaces button {
          /* Color Config */
          background-color: rgba(50, 50, 50, 0.5);
          color:white;

          /* Padding and Margin Config */
          padding: 0px 10px;
          margin: 5px 2px;
        }

        #workspaces button.active {
          /* Color Config */
          background-color: rgba(0, 0, 0, 1.0);
          color:white;
        }

        #network,
        #temperature,
        #pulseaudio,
        #backlight,
        #battery,
        #clock {
          /* Color Config */
          background-color: rgba(0, 0, 0, 1.0);
          color:white;

          /* Padding and Margin Config */
          padding: 0px 10px;
          margin: 5px 3px;
        }

        #battery {
          /* Padding Config */
          padding-left: 10px;
          padding-right: 10px
        }
      '';
    };
  };
}
