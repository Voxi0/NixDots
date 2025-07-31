{
  lib,
  config,
  inputs,
  ...
}: let
  numInputDevices = lib.range 1 11;
  inputDevices = map (i: "/dev/input/event${toString i}") numInputDevices;
in {
  # Import Nix modules
  imports = [inputs.bongocat.nixosModules.default];

  # Module options
  options.enableBongocat = lib.mkEnableOption "Enable Bongocat overlay for Wayland";

  # Configuration
  config = lib.mkIf config.enableBongocat {
    programs.wayland-bongocat = {
      inherit inputDevices;
      enable = true;
      autostart = false;
      overlayOpacity = 0;
    };
  };
}
