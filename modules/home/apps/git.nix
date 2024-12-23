{ lib, config, ... }: {
  # Module options
  options = {
    enableGit = lib.mkEnableOption "Enables Git";
  };

  # Configure Git if it's enabled
  config = lib.mkIf config.enableGit {
    programs.git = {
      enable = true;
      userName = "Voxi0";
      userEmail = "alif200099@gmail.com";
      extraConfig.init.defaultBranch = "main";
    };
    programs.lazygit = {
      enable = true;
      settings = {
        gui.theme.lightTheme = false;
      };
    };
  };
}
