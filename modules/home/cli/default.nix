{
  lib,
  config,
  pkgs,
  ...
}: {
  # Import Nix modules
  imports = [
    ./fastfetch.nix # Modern system info tool designed to replace Neofetch
    ./git.nix # Git and LazyGIT (Beautiful TUI for Git that makes using Git super fast and easy)
    ./yazi.nix # Fancy and modern TUI file manager written in Rust with previews and such
    ./ncmpcpp.nix # MPD client - TUI music player
  ];

  # Module options
  options.cli = {
    enableNixHelper = lib.mkEnableOption "Enable Nix Helper CLI - Reimplements well known NixOS commands for a better interface and more features";
    enableBtop = lib.mkEnableOption "Enable Btop - Terminal based system resource monitor";
  };

  # Configuration
  config = lib.mkMerge [
    # Default
    {
      # Useful programs
      programs = {
        nix-your-shell.enable = true; # Use preferred shell instead of Bash in Nix shells
        zoxide.enable = true; # Smarter `cd` command
      };
    }

    # Useful/Handy CLI utilities
    (lib.mkIf config.cli.enableNixHelper {home.packages = [pkgs.nh];})
    (lib.mkIf config.cli.enableBtop {home.packages = [pkgs.btop];})
  ];
}
