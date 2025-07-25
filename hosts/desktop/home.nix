_: {
  # Import Nix modules
  imports = [../../modules/home];

  # IF USING NIXOS THEN ENABLE THIS OPTION IN NIXOS CONFIGURATION TOO
  enableFish = true;
  desktops.enableHyprland = true;

  # Enable/Disable Home Manager modules
  enableStylix = true;
  cli = {
    enableNixHelper = true;
    enableGit = true;
    enableFastfetch = true;
    enableBtop = true;
    enableYazi = true;
    enableNcmpcpp = true;
  };
  apps = {
    enableKitty = true;
    enableFirefox = true;
    enableSpotify = true;
    enableDiscord = true;
    enableOBS = true;
  };
  gaming = {
    enableLutris = true;
    enableHeroic = false;
  };
}
