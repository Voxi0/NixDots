{ lib, config, ... }: {
  # Module options
  options.enableWlogout = lib.mkEnableOption "Wlgout (Wayland logout menu)";

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
        button:hover {background-color: #091059;}
        button {
          background-color: #000000;
          color: #ffffff;
          border: none;
          border-radius: 6px;
          margin: 0px 6px;
          transition-duration: 0.2s;
        }
      '';
    };
  };
}
