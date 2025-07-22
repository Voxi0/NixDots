{
  lib,
  config,
  pkgs,
  ...
}: {
  # Import Nix modules
  imports = [
    ./fastfetch.nix # Modern system info tool designed to replace Neofetch
    ./ncmpcpp.nix # MPD client - TUI music player
  ];

  # Module options
  options.cli = {
    enableNixHelper = lib.mkEnableOption "Enable Nix Helper CLI - Reimplements well known NixOS commands for a better interface and more features";
    enableGit = lib.mkEnableOption "Enable Git - The most popular version control system";
    enableBtop = lib.mkEnableOption "Enable Btop - Terminal based system resource monitor";
    enableYazi = lib.mkEnableOption "Enable Yazi - A modern and fancy TUI file manager with file previews and such";
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

    # Git and LazyGIT (Beautiful TUI for Git that makes using Git super fast and easy)
    (lib.mkIf config.cli.enableGit {
      home.packages = with pkgs; [git];
      programs.lazygit = {
        enable = true;
        settings = {
          gui.theme = {
            lightTheme = false;
            activeBorderColor = ["blue" "bold"];
            inactiveBorderColor = ["black"];
            selectedLineBgColor = ["default"];
          };
        };
      };
    })

    # Fancy and modern TUI file manager written in Rust with previews and such
    (lib.mkIf config.cli.enableYazi {
      programs.yazi = {
        enable = true;
        settings = {
          input.cursor_blink = false;
          mgr = {
            ratio = [1 2 3]; # Parent, current and preview windows width
            show_hidden = false;
            show_symlink = false;
            sort_by = "natural";
            sort_reverse = false;
            sort_sensitive = true;
            linemode = "size";
          };
          preview = {
            wrap = "no";
            image_filter = "nearest";
            image_quality = 50;
          };
        };
      };
    })
  ];
}
