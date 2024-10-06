{ lib, config, pkgs, ... }: {
  # Module options
  options = {
    enableVesktop = lib.mkEnableOption "Enables Vesktop";
  };

  # Configure Vesktop only if it's enabled
  config = lib.mkIf config.enableVesktop {
    home.packages = [ pkgs.vesktop ];
  };
}
