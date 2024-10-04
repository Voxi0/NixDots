{ lib, config, ... }: {
  # Module options
  options = {
    git.enable = lib.mkEnableOption "Enables Git";
  };

  # Configure Git if it's enabled
  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userName = "Voxi0";
      userEmail = "alif200099@gmail.com";
    };
    programs.lazygit = {
      enable = true;
      settings = {
        gui.theme.lightTheme = false;
      };
    };
  };
}
