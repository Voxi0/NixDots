{ pkgs, ... }: {
  # Extra CLI tools
  home = {
    # Extra CLI tools
    packages = with pkgs; [
      nh          # Nix CLI helper
      binsider    # Analyze ELF binaries like a boss 😼🕵️
      btop        # System monitor
      tokei       # Shows the number of lines of comments, code etc in projects
			astroterm		# Terminal based star map written in C
    ];

    # Shell alises to shorten useful commands
    shellAliases = {
			"ff" = "fastfetch";
			"starmap" = "astroterm -f 60 -c -u";
		};
  };

  # Programs
  programs = {
    nix-your-shell.enable = true; # Use the shell we prefer instead of Bash in Nix shells
    zoxide.enable = true;         # Smarter `cd` command which is super handy

    # A clone of `cat` with syntax highlighting, Git integration etc
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        prettybat batman batpipe batgrep batdiff
      ];
    };

    # Fetch script
    fastfetch = {
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
