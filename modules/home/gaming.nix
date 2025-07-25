{
  lib,
  config,
  pkgs,
  ...
}: {
  # Module options
  options.gaming = {
    enable = lib.mkEnableOption "Enable gaming related stuff";
    enableLutris = lib.mkEnableOption "Enable Lutris game launcher";
    enableHeroic = lib.mkEnableOption "Enable Heroic game launcher";
  };

  # Configuration
  config = lib.mkIf config.gaming.enable {
    home.packages = lib.mkIf config.gaming.enableHeroic [pkgs.heroic];
    programs.lutris = lib.mkIf config.gaming.enableLutris {
      enable = true;
      protonPackages = [pkgs.proton-ge-bin];
      winePackages = [pkgs.wineWow64Packages.full];
    };
  };
}
