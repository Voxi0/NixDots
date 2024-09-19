{ lib, config, pkgs, ... }: {
  # Module options
  options = {
    vesktop.enable = lib.mkEnableOption "Enables Vesktop";
  };

  # Configure Vesktop only if it's enabled
  config = lib.mkIf config.vesktop.enable {
    home.packages = [ pkgs.vesktop ];
  };
}
