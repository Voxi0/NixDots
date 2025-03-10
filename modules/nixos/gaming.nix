{ lib, config, pkgs, ... }: {
  # Module options
  options.gaming = {
    enable = lib.mkEnableOption "gaming related stuff";
    enableSteam = lib.mkEnableOption "Steam";
    enableLutris = lib.mkEnableOption "Lutris game launcher";
    enableHeroic = lib.mkEnableOption "Heroic game launcher";
  };

  # Configuration
  config = lib.mkIf config.gaming.enable {
    # Extra packages
    environment = {
      # ProtonGE Installation path - Used by the `protonup` command
      sessionVariables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/user/.steam/root/compatibilitytools.d";

      # Extra packages
      systemPackages = with pkgs; [
        protonup  # Allows you to install ProtonGE, imperatively
        mangohud  # Monitor game FPS and stuff
      ] ++ (if config.gaming.enableLutris then
        [ pkgs.lutris ]
      else []) ++ (if config.gaming.enableHeroic then
        [ pkgs.heroic ]
      else []);
    };

    # Programs
    programs = {
      # A daemon that greatly improves game performance by requesting a set of optimizations to be temporarily applied to the OS and the game process
      gamemode.enable = true;

      # Steam
      steam = lib.mkIf config.gaming.enableSteam {
        enable = true;
        gamescopeSession.enable = true; # Optimized micro-compositor that may helps with upscaling and resolution issues
      };
    };
  };
}
