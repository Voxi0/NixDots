{ pkgs, ... }: {
  # Home
  home = {
    # Extra CLI packages/tools
    packages = with pkgs; [
      nh btop superfile
    ];
  };

  # Configure the shell, terminal emulator and everything else e.g. a fetch script
  programs = {
    # Nushell
    nushell = {
      enable = true;
      package = pkgs.nushell;
      plugins = with pkgs.nushellPlugins; [
        highlight
      ];
      shellAliases = {
        ff = "fastfetch";

        update-switch = "nh os switch -H";
        update-boot = "nh os boot -H";
        update-test = "nh os test -H";
        clean = "nh clean all";
      };
      extraConfig = "
        $env.config.show_banner = false
      ";
    };

    # Kitty - Terminal emulator
    kitty = {
      enable = true;
      settings = {
        # Disable popup confirmation window when closing Kitty terminal
        confirm_os_window_close = 0;

        # Font
        font_size = "11.0";

        # Cursor
        cursor_shape = "beam";
        cursor_beam_thickness = "1.0";
        cursor_blink_interval = 0;

        # Performance tuning
        sync_to_monitor = true;

        # Terminal bell
        enable_audio_bell = true;
        window_alert_on_bell = true;
      };
    };

    # Minimal, blazing-fast, and infinitely customizable prompt for any shell
    starship = {
      enable = true;
      enableNushellIntegration = true;
      package = pkgs.starship;

      # Fish shell only
      enableInteractive = false;
      enableTransience = false;

      # Settings
      settings = {
        add_newline = false;
        character = {
          success_symbol = "[->](bold green)";
          error_symbol = "[->](bold red)";
        };
      };
    };

    # Use the shell we prefer inside of Nix shells instead of Bash
    nix-your-shell = {
      enable = true;
      enableNushellIntegration = true;
      package = pkgs.nix-your-shell;
    };

    # Corrects errors in previous commands
    thefuck = {
      enable = true;
      enableNushellIntegration = true;
      enableInstantMode = false;
      package = pkgs.thefuck;
    };

    # Smarter 'cd' command
    zoxide = {
      enable = true;
      enableNushellIntegration = true;
      package = pkgs.zoxide;
    };

    # Fetch script
    fastfetch = {
      enable = true;
      package = pkgs.fastfetch;
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
            format = "{user-name}";}

          # Distro name, kernel
          {
            type = "os";
            key = " ";
            format = "{3}";}
          {
            type = "kernel";
            key = " ";
            format = "{1} {2}";}

          # Shell, Window Manager (WM) / Desktop Environment (DE) and terminal
          {
            type = "shell";
            key = " ";
            format = "{6}";}
          {
            key = " ";
            type = "wm";}
          {
            key = "󱂬 ";
            type = "de";}
          {
            type = "terminal";
            key = " ";
            format = "{5}";}
        ];
      };
    };
  };
}
