{ lib, config, pkgs, ... }: {
  # Module options
  options = {
    enableHyprpanel = lib.mkEnableOption "Enables Hyprpanel";
  };

  # Configure Hyprpanel if it's enabled
  config = lib.mkIf config.hyprpanel.enable {
    home.packages = pkgs.hyprpanel;
    wayland.windowManager.hyprland.settings.exec-once = [
      "${pkgs.hyprpanel}/bin/hyprpanel"
    ];
  };
}
