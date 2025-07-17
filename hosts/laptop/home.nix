_: {
  # Import Nix modules
  imports = [../../modules/home];

  # Enable/Disable our Home Manager modules
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
