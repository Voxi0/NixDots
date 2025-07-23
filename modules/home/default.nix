{
  inputs,
  system,
  username,
  pkgs,
  ...
}: {
  # Import Nix modules
  imports = [
    ./wallpapers # Wallpapers
    ./desktops # Desktop environments and window managers
    ./stylix.nix # System-wide theming and typography
    ./fish.nix
    ./cli # Terminal shell + CLI utils and such
    ./apps
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
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
