{
  lib,
  config,
  pkgs,
  ...
}: {
  # Module options
  options.gaming = {
    enable = lib.mkEnableOption "Enable gaming related stuff";
    enableSteam = lib.mkEnableOption "Enable Steam";
    enableRoblox = lib.mkEnableOption "Enable Sober for playing Roblox";
  };

  # Configuration
  config = lib.mkIf config.gaming.enable {
    services = {
      # Low-latency audio
      pipewire.lowLatency.enable = lib.mkIf config.enablePipewire true;

      # Install Sober (Roblox player/client) - Only available as a Flatpak for now
      flatpak = lib.mkIf config.gaming.enableRoblox {
        enable = true;
        update.auto.enable = false;
        packages = [
          {
            appId = "org.vinegarhq.Sober";
            origin = "flathub";
          }
        ];
      };
    };

    # Configure Steam and other stuff to improve game performance
    hardware.steam-hardware.enable = true;
    programs = {
      gamemode.enable = true;
      gamescope = {
        enable = true;
        capSysNice = true;
      };
      steam = lib.mkIf config.gaming.enableSteam {
        enable = true;
        platformOptimizations.enable = true;
        extraCompatPackages = [pkgs.proton-ge-bin];
      };
    };
  };
}
