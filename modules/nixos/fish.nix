{
  lib,
  config,
  username,
  pkgs,
  ...
}: {
  # Module options
  options.enableFish = lib.mkEnableOption "Enable Fish shell";

  # Configuration
  config = lib.mkIf config.enableFish {
    # Keep using Bash as the system/login shell
    programs.bash = {
      # Bring up UWSM compositor selection menu after logging in
      loginShellInit = ''
        if uwsm check may-start && uwsm select; then
        	exec uwsm start default
        fi
      '';

      # Start Fish when running interactively
      # This is because Fish isn't POSIX compliant meaning it could cause issues if used as the login shell
      interactiveShellInit = ''
        # Launch Fish unless the parent process is already Fish
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
        	shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        	exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };

    # Enable vendor Fish completions provided by Nixpkgs
    programs.fish.enable = true;

    # Home Manager
    home-manager.users.${username}.programs = {
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
  };
}
