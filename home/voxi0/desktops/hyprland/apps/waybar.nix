{ config, pkgs, ... }: {
  # Waybar Configuration
  programs.waybar = {
    # Enable Waybar
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        # Position and Layer
        layer = "top";
        position = "top";
        height = 40;

        # Modules
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "network" "temperature" "pulseaudio" "backlight" "battery" "tray" ];

        # Clock Config
        "clock" = {
          format = "{:%H:%M}";
          format-alt = "{:%A %d %B %Y}";
        };

        # Temperature Config
        "temperature" = {
          format = "{temperatureC}°C ";
        };

        # Pulseaudio Config
        "pulseaudio" = {
          format = "{volume}% 󰕾";
        };

        # Backlight Config
        "backlight" = {
          format = "{percent}% 󰃞";
        };

        # Internet Config
        "network" = {
          format-wifi = "{essid} ({signalStrength}%)";
        };
        
        # Battery Config
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
}
