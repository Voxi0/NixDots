{ lib, config, username, pkgs, ... }: {
  # Module options
  options.enableFish = lib.mkEnableOption "Fish shell";

  # Configuration
  config = lib.mkIf config.enableFish {
    # Keeping Bash as the system shell but having it start Fish when run interactively
    # Launches Fish unless the parent process is already Fish
    programs.bash.interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';

    # To get full completion
    programs.fish.enable = true;

    # Home Manager
    home-manager.users.${username} = {
      # Programs
      programs = {
        # Fish shell
        fish = {
          enable = true;
          generateCompletions = true;
          interactiveShellInit = ''
            # Disable greeting
            set fish_greeting
          '';
        };

        # Minimal, blazing-fast, and infinitely customizable prompt for any shell
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
    };
  };
}
