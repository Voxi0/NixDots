{ lib, config, ... }: {
  # Module options
  options.enableWlogout = lib.mkOption {
    type = lib.types.bool;
    default = false;
    example = true;
    description = "Enable Wlogout";
  };

  # Configuration
  config = lib.mkIf config.enableWlogout {
    # Wlogout - Wayland logout menu
    programs.wlogout = {
      enable = true;
      layout = [
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
          keybind = "s";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Restart";
          keybind = "r";
        }
        {
          label = "lockscreen";
          action = "hyprlock";
          text = "Lock Screen";
          keybind = "l";
        }
      ];
      style = ''
        button {
          background-color: #000000;
          color: #ffffff;
          border: none;
          border-radius: 6px;
          margin: 0px 6px;
          transition-duration: 0.2s;
        }
        button:hover {background-color: #091059;}
      '';
    };
  };
}
