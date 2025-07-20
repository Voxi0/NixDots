{
  inputs,
  system,
  username,
  pkgs,
  ...
}: {
  # Import Nix modules
  imports = [
    ./desktops # Desktop environments and window managers
    ./kitty.nix # Terminal emulator
    ./fish.nix
    ./cli.nix # Terminal shell + CLI utils and such
    ./git.nix # Git (Version Control System (VCS)) and LazyGit
    ./browser # Web browser
    ./music # Music related stuff e.g. Spotify and MPD
    ./discord.nix # Discord
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
    # User information
    inherit username;
    homeDirectory = "/home/${username}";

    # Never change this value
    stateVersion = "25.05";

    # Default packages that should be installed
    packages = with pkgs;
      [
        unzip # To unzip zip files
        neohtop # GUI system monitor
        mpv # Media player
        wget # To download files
        curl # To make HTTP requests
        obsidian # Free and open source Markdown note taking application
      ]
      ++ [inputs.NixNvim.packages.${pkgs.system}.nvim];

    # Make Neovim the default editor
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    # User files
    file = {
      # Wallpapers
      "Pictures/Wallpapers" = {
        source = ./../../modules/home/Pictures/Wallpapers;
        recursive = true;
      };
    };
  };

  # Programs
  programs = {
    # For screen recording
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs # Lets you capture from Wlroots based Wayland compositors
        obs-pipewire-audio-capture # Pipewire audio capturing
        obs-vaapi # GStreamer based VAAPI encoder implementation - Supports H.264, H.265 and AV1
        obs-vkcapture # For Vulkan/OpenGL game capture on Linux
      ];
    };

    # Let Home Manager install and manage itself
    home-manager.enable = true;
  };
}
