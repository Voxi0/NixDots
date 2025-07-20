{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Import Nix modules
  imports = with inputs; [
    # Flatpak for Sober (Roblox client)
    nix-flatpak.nixosModules.nix-flatpak

    # Extra optimizations and stuff for gaming
    nix-gaming.nixosModules.ntsync
    nix-gaming.nixosModules.pipewireLowLatency
    nix-gaming.nixosModules.platformOptimizations
  ];

  # Module options
  options.gaming = {
    enable = lib.mkEnableOption "Enable gaming related stuff";
    enableSteam = lib.mkEnableOption "Enable Steam";
    enableRoblox = lib.mkEnableOption "Enable Sober for playing Roblox";
    enableLutris = lib.mkEnableOption "Enable Lutris game launcher";
    enableHeroic = lib.mkEnableOption "Enable Heroic game launcher";
  };

  # Configuration
  config = lib.mkIf config.gaming.enable {
    # Low latency audio
    services.pipewire.lowLatency.enable = lib.mkIf config.enablePipewire true;

    # Install Sober (Roblox) - Only available as a Flatpak for now
    services.flatpak = lib.mkIf config.gaming.enableRoblox {
      enable = true;
      update.auto.enable = false;
      packages = [
        {
          appId = "org.vinegarhq.Sober";
          origin = "flathub";
        }
      ];
    };

    # Extra packages
    environment = {
      # Extra packages
      systemPackages = with pkgs;
        [
          mangohud # Monitor game performance
        ]
        ++ (
          if config.gaming.enableLutris
          then [pkgs.lutris]
          else []
        )
        ++ (
          if config.gaming.enableHeroic
          then [pkgs.heroic]
          else []
        )
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
