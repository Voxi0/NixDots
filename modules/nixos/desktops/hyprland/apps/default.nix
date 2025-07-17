{pkgs, ...}: {
  # Import Nix modules
  imports = [
    ./playerctl.nix # To control media players via commands
    ./wofi # App launcher
    ./swaync.nix # Sway notification centre
    ./wlogout.nix # Logout menu
  ];

  # Quickshell - For widgets and such
  home.packages = [pkgs.quickshell];
  programs.quickshell = {
    enable = true;
    systemd.enable = true;
    activeConfig = "default";
    configs = {
      default = ../quickshell;
    };
  };
}
