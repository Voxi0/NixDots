{ inputs, lib, config, pkgs, ... }: {
  # Import Nix modules
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

  # Module options
  options.gaming = {
    enable = lib.mkEnableOption "gaming related stuff";
    enableSteam = lib.mkEnableOption "Enable Steam";
    enableRoblox = lib.mkEnableOption "Enable Sober for playing Roblox";
    enableLutris = lib.mkEnableOption "Enable Lutris game launcher";
    enableHeroic = lib.mkEnableOption "Enable Heroic game launcher";
  };

  # Configuration
  config = lib.mkIf config.gaming.enable {
    # Install Sober Flatpak
    services.flatpak = lib.mkIf config.gaming.enableRoblox {
      enable = true;
      update.auto.enable = false;
      packages = [ { appId = "org.vinegarhq.Sober"; origin = "flathub"; } ];
    };

    # Extra packages
    environment = {
			# Where to install Proton and other compatibility stuff for Steam
      sessionVariables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/user/.steam/root/compatibilitytools.d";

      # Extra packages
      systemPackages = with pkgs; [
        protonup  # Imperatively install ProtonGE
        mangohud  # Monitor game performance
      ] ++ (if config.gaming.enableLutris then
        [ pkgs.lutris ]
      else []) ++ (if config.gaming.enableHeroic then
        [ pkgs.heroic ]
      else []);
    };

    # Programs
    programs = {
			# Daemon that temporarily applies a set of optimizations to the OS and the game to greatly increase performance
      gamemode.enable = true;

      # Steam
      steam = lib.mkIf config.gaming.enableSteam {
        enable = true;
        gamescopeSession.enable = true; # Optimized micro-compositor that may help with upscaling and resolution issues
      };
    };
  };
}
