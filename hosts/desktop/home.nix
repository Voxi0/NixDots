_: {
  # Import Nix modules
  imports = [../../modules/home];

  # IF USING NIXOS THEN ENABLE THIS OPTION IN NIXOS CONFIGURATION TOO
  enableFish = true;
  desktop.hyprland.enable = true;

  # Enable/Disable Home Manager modules
  enableKitty = true;
  enableFirefox = true;
  enableGit = true;
  enableSpotify = true;
  enableMPD = true;
  enableNcmpcpp = true;
  enableDiscord = true;
  cli = {
    enableNixHelper = true;
    enableFastfetch = true;
    enableBtop = true;
    enableYazi = true;
  };
}
