{
  lib,
  config,
  pkgs,
  ...
}: {
  # Module options
  options.cli = {
    enableNixHelper = lib.mkEnableOption "Enable Nix Helper CLI - Reimplements well known NixOS commands for a better interface and more features";
    enableFastfetch = lib.mkEnableOption "Enable Fastfetch - A feature-rich and performant system information tool";
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

    # Fetch script
    (lib.mkIf config.cli.enableFastfetch {
      home.shellAliases."ff" = "fastfetch";
      programs.fastfetch = {
        enable = true;
        settings = {
          logo = {
            source = "nixos_small";
            padding.right = 2;
          };

          display = {
            color = "red";
            separator = "";
          };

          modules = [
            # Username and hostname
            {
              type = "title";
              # To display host name next to username - {at-symbol-colored}{host-name-colored}
              key = " ";
              format = "{user-name}";
            }

            # Distro name, kernel
            {
              type = "os";
              key = " ";
              format = "{3}";
            }
            {
              type = "kernel";
              key = " ";
              format = "{1} {2}";
            }

            # Shell, Window Manager (WM) / Desktop Environment (DE) and terminal
            {
              type = "shell";
              key = " ";
              format = "{6}";
            }
            {
              key = " ";
              type = "wm";
            }
            {
              key = "󱂬 ";
              type = "de";
            }
            {
              type = "terminal";
              key = " ";
              format = "{5}";
            }
          ];
        };
      };
    })
  ];
}
