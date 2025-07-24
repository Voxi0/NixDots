{
  lib,
  config,
  pkgs,
  ...
}: {
  # Module options
  options.cli.enableGit = lib.mkEnableOption "Enable Git - The most popular version control system";

  # Git and LazyGIT (Beautiful TUI for Git that makes using Git super fast and easy)
  config = lib.mkIf config.cli.enableGit {
    home.packages = with pkgs; [git];
    programs.lazygit = {
      enable = true;
      settings = {
        gui.theme = {
          lightTheme = false;
          activeBorderColor = ["blue" "bold"];
          inactiveBorderColor = ["black"];
          selectedLineBgColor = ["default"];
        };
      };
    };
  };
}
