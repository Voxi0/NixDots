{username, ...}: {
  # Tell Home Manager that we aren't on Non NixOS
  targets.genericLinux.enable = true;

  # User home
  home = {
    inherit username;
    homeDirectory = "/usr/home/${username}";
    stateVersion = "25.05";
  };

  # Enable/Disable NixDots modules
  enableStylix = false;

  # NOT RECOMMENDED
  desktops.enableHyprland = false;

  # CLI
  cli = {
    enableNixHelper = false;
    enableGit = false;
    enableFastfetch = false;
    enableBtop = false;
    enableYazi = false;
    enableNcmpcpp = false;
  };

  # Apps
  apps = {
    enableKitty = false;
    enableFirefox = false;
    enableSpotify = false;
    enableDiscord = false;
    enableOBS = false;
  };

  # Let Home-Manager install and manage itself
  programs.home-manager.enable = true;
}
