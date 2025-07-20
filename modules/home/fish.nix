{
  lib,
  config,
  ...
}: {
  # Module options
  options.enableFish = lib.mkEnableOption "Enable Fish shell";

  # Configuration
  config.programs = lib.mkIf config.enableFish {
    # Fish shell
    fish = {
      enable = true;
      generateCompletions = true;
      interactiveShellInit = ''
        # Disable greeting
        set fish_greeting
      '';
    };

    # Fast, minimal and customizable shell prompt
    starship = {
      enable = true;
      enableFishIntegration = true;

      # Fish shell only
      enableInteractive = true;
      enableTransience = true;

      # Settings
      settings = {
        add_newline = false;
        character = {
          success_symbol = "[->](bold green)";
          error_symbol = "[->](bold red)";
        };
      };
    };

    # Shell integrations
    kitty.shellIntegration.enableFishIntegration = true;
    nix-your-shell.enableFishIntegration = true;
    zoxide.enableFishIntegration = true;
  };
}
