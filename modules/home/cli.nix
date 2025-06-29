{ pkgs, ... }: {
  # Extra CLI tools
  home = {
    # Extra CLI tools
    packages = with pkgs; [
      nh				# Nix CLI helper
			btop			# System monitor
			cbonsai		# Bonsai tree generator written in C using Ncurses
			genact		# A nonsense activity generator
			cmatrix		# Terminal based "The Matrix" like implementation
			astroterm	# Terminal based star map written in C displaying real time positions of stars, planets, constellations etc
    ];

    # Shell alises to shorten frequently used commands
    shellAliases = {
			"ff" = "fastfetch";
			"starmap" = "astroterm --fps=120 --unicode --color";
		};
  };

  # Programs
  programs = {
    nix-your-shell.enable = true; # Use the shell we prefer instead of Bash in Nix shells
    zoxide.enable = true;         # Smarter `cd` command which is super handy

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
