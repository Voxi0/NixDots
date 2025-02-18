{ pkgs, ... }: {
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
}
