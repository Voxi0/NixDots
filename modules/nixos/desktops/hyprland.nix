{
  lib,
  config,
  system,
  inputs,
  ...
}: {
  # Module options
  options.desktops.enableHyprland = lib.mkEnableOption "Enable Hyprland Wayland compositor";

  # Configuration
  config = lib.mkIf config.desktops.enableHyprland {
    # Required as it enables critical components needed to run Hyprland properly
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${system}.hyprland;
      portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
    };

    # D-Bus service to access and manipulate storage devices
    services.udisks2.enable = true;
  };
}
