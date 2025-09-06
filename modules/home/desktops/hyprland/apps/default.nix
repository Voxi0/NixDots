{pkgs, ...}: {
  # Import Nix modules
  imports = [
    ./playerctl.nix # To control media players via commands
    ./vicinae.nix # Launcher
    ./swaync.nix # Sway notification centre
    ./wlogout.nix # Logout menu
  ];

  # Quickshell - For widgets and such
  home.packages = [pkgs.quickshell];
  programs.quickshell = {
    enable = true;
    systemd.enable = false;
    activeConfig = "default";
    configs.default = ../quickshell;
  };
}
