{ lib, config, pkgs, ... }: {
  # Module options
  options.enableGaming = lib.mkOption {
    type = lib.types.bool;
    default = false;
    example = true;
    description = "Enable Gaming Related Stuff";
  };

  # Configuration
  config = lib.mkIf config.enableGaming {
    # Extra packages
    environment = {
      sessionVariables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/user/.steam/root/compatibilitytools.d";
      systemPackages = with pkgs; [
        protonup
        mangohud  # Monitor game FPS and stuff
      ];
    };

    # Programs
    programs = {
      # Game mode
      gamemode.enable = true;

      # Steam
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
    };
  };
}
