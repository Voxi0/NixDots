{
  lib,
  config,
  pkgs,
  ...
}: {
  # Module options
  options.enableGit = lib.mkEnableOption "Enable Git";

  # Configuration
  config = lib.mkIf config.enableGit {
    # Git and LazyGIT (Beautiful TUI for Git with keybinds to make using Git super fast and easy)
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
