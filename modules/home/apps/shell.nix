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
      package = pkgs.kitty;
      settings = {
        # Disable popup confirmation window when closing Kitty terminal
        confirm_os_window_close = 0;

        # Cursor
        cursor_shape = "beam";
        cursor_beam_thickness = "1.0";
        cursor_blink_interval = "0";
        cursor_trail = "3";
        cursor_trail_decay = "0.1 0.4";
        cursor_trail_start_threshold = "1";

        # Performance tuning
        sync_to_monitor = true;

        # Number of lines of history to keep in memory for scrolling back
        scrollback_lines = 1000;

        # Tab bar position, style and alignment
        tab_bar_edge = "top";
        tab_bar_min_tabs = "1";
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        tab_bar_align = "left";

        # When the current tab is closed, go back to the previous tab
        tab_switch_strategy = "previous";

        # Tab bar title
        tab_title_max_length = "0";
        tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}";

        # Active/Inactive tab style
        active_tab_font_style = "bold";
        inactive_tab_font_style = "normal";

        # Window layouts
        enabled_layouts = "splits:split_axis=horizontal,*";
        window_margin_width = "2";

        # Terminal bell
        enable_audio_bell = false;
        window_alert_on_bell = true;
        
        # URLs
        detect_urls = true;
        url_prefixes = "file ftp ftps gemini git gopher http https irc ircs kitty mailto news sftp ssh";
        underline_hyperlinks = "always";
        url_style = "curly";
        open_url_with = "default";
      };

      # Keybindings
      keybindings = {
        # For the split layout
        # Move the active window in the indicated direction
        "shift+up" = "move_window up";
        "shift+left" = "move_window left";
        "shift+right" = "move_window right";
        "shift+down" = "move_window down";

        # Move the active window to the indicated screen edge
        "ctrl+shift+up" = "layout_action move_to_screen_edge top";
        "ctrl+shift+left" = "layout_action move_to_screen_edge left";
        "ctrl+shift+right" = "layout_action move_to_screen_edge right";
        "ctrl+shift+down" = "layout_action move_to_screen_edge bottom";

        # Switch focus to the neighboring window in the indicated direction
        "ctrl+alt+left" = "neighboring_window left";
        "ctrl+alt+right" = "neighboring_window right";
        "ctrl+alt+up" = "neighboring_window up";
        "ctrl+alt+down" = "neighboring_window down";
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
