{ inputs, system, pkgs, ... }: {
	# Import Nix modules
	imports = [
		./kitty.nix										# Terminal emulator
		./cli.nix											# CLI applications and such
		./git.nix											# Git (Version Control System (VCS)) and LazyGit
		./browser											# Web browser
		./music												# Music related stuff e.g. Spotify and MPD
		./discord.nix									# Discord
	];

	# GTK and QT
  qt.enable = true;
  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  # XDG user directories
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # Manage user files
  home = {
    # Default packages that should be installed
    packages = with pkgs; [
      unzip												# To unzip zip files
			mpv													# Media player
			wget												# To download files
			curl												# To make HTTP requests
      obsidian										# Free and open source Markdown note taking application
    ] ++ [ inputs.NixNvim.packages.${system}.nvim ];

    # User files
    file = {
      # Wallpapers
      "Pictures/Wallpapers" = {
        source = ./../../modules/home/Pictures/Wallpapers;
        recursive = true;
      };
    };
  };

	# OBS studio for screen recording
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs											# Lets you capture from Wlroots based Wayland compositors e.g. Sway
      obs-pipewire-audio-capture	# Pipewire audio capturing
			obs-vaapi										# GStreamer based VAAPI encoder implementation - Supports H.264, H.265 and AV1
      obs-vkcapture								# For Vulkan/OpenGL game capture on Linux
    ];
  };
}
