{ pkgs, lib, config, ... }: {
  # Module options
  options = {
    enableZSH = lib.mkEnableOption "Enables ZSH";
    enableKitty = lib.mkEnableOption "Enables Kitty";
  };

  config = {
    # Home
    home.shellAliases = {
			"ff" = "fastfetch";

      "ls" = "eza";
      "ll" = "eza -l";
      "la" = "eza --all";
      "lla" = "eza --all -l";

      "update-switch" = "nh os switch -H";
      "update-boot" = "nh os boot -H";
      "update-test" = "nh os test -H";
      "clean" = "nh clean all";
    };

    # Install ZSH packages
    home.packages = with pkgs; [
      nh lf btop
    ] ++ (if config.enableZSH then
      (with pkgs; [
        oh-my-zsh thefuck fzf
      ])
    else []);

    # Configure shell, the terminal emulator and everything else e.g. Fastfetch
    programs = {
      # ZSH - Extended Bourne shell with many improvements
      zsh = lib.mkIf config.enableZSH {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        # Command history
        history.size = 1000;

        # Oh-My-ZSH
        oh-my-zsh = {
          enable = true;
          plugins = [ "git" "thefuck" "fzf" ];
          theme = "lambda";
        };
      };

      # Kitty - Terminal emulator
			kitty = lib.mkIf config.enableKitty {
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

			# Eza - A modern alternative to 'ls'
			eza = {
				enable = true;
				icons = "auto";
				git = true;
				extraOptions = [
					"--colour=always"
				];
			};

			# Fetch script configurations
			# Fastfetch
			fastfetch = {
				enable = true;
				package = pkgs.fastfetch;
				settings = {
					logo = {
						type = "kitty-direct";
            source = ../Pictures/Fastfetch/42willow.gif;
            width = 42;
            height = 18;
            padding = {
              top = 1;
              left = 2;
            };
					};

          display.separator = "";

          modules = [
            {
              type = "custom";
              format = "╔══════════════════════════════════════════════════════╗";}
            {
              type = "os";
              key = "  󰣇  OS        ║";
              format = " {3}";}
            {
              type = "kernel";
              key = "    Kernel    ║ ";
              format = "{1} {2}";}
            {
              type = "uptime";
              key = "    Uptime    ║ ";
              format = "{2} hours, {3} mins";}
            {
              type = "packages";
              key = "  󰏗  Packages  ║ ";
              format = "{2} (pacman){?3}[{3}]{?}";}
            {
              type = "shell";
              key = "    Shell     ║ ";
              format = "{6}";}
            {
              type = "terminal";
              key = "    Terminal  ║ ";
              format = "{5}";}
            {
              type = "custom";
              format = "╚══════════════════════════════════════════════════════╝";}

            { type = "break"; }

            {
              type = "colors";
              paddingLeft = "20";
              symbol = "circle";}

            { type = "break"; }

            {
              type = "custom";
              format = "╔══════════════════════════════════════════════════════╗";}
            {
              type = "display";
              key = "  󰍹  Display   ║ ";
              format = "{1}x{2}";}
            {
              type = "cpu";
              key = "    CPU       ║ ";
              format = "{1}";}
            {
              type = "gpu";
              key = "  󰊴  GPU       ║ ";
              format = "{2}";}
            {
              type = "memory";
              key = "    Memory    ║ ";
              format = "{1} / {2} ({3})";}
            {
              type = "custom";
              format = "╚══════════════════════════════════════════════════════╝";}
          ];
				};
			};
    };
  };
}
