{
  lib,
  config,
  inputs,
  ...
}: {
  # Import Nix modules
  imports = [inputs.bongocat.nixosModules.default];

  # Module options
  options.enableBongocat = lib.mkEnableOption "Enable Bongocat overlay for Wayland";

  # Configuration
  config = lib.mkIf config.enableBongocat {
    programs.wayland-bongocat = {
      enable = true;
      autoStart = true;
    };
  };
}
