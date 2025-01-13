{ lib, config, username, email, ... }: {
  # Module options
  options.enableGit = lib.mkEnableOption "Enables Git";

  # Configure Git if it's enabled
  config = lib.mkIf config.enableGit {
    # Git CLI
    programs.git = {
      enable = true;
      userName = username;
      userEmail = email;
      extraConfig.init.defaultBranch = "main";
    };

    # Simple TUI for Git commands
    programs.lazygit = {
      enable = true;
      settings.gui.theme.lightTheme = false;
    };
  };
}
