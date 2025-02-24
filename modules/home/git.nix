{ lib, config, pkgs, ... }: {
  # Module options
  options.enableGit = lib.mkEnableOption "Git (Version Control System (VCS))";

  # Configuration
  config = lib.mkIf config.enableGit {
    # Git
    home.packages = with pkgs; [ git ];

    # LazyGit - Simple and beautiful TUI for Git
    programs.lazygit = {
      enable = true;
      settings = {
        gui.theme = {
          lightTheme = false;
          activeBorderColor = [ "blue" "bold" ];
          inactiveBorderColor = [ "black" ];
          selectedLineBgColor = [ "default" ];
        };
      };
    };
  };
}
