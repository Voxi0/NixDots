{
  lib,
  config,
  pkgs,
  ...
}: {
  # Module options
  options.enableFish = lib.mkEnableOption "Enable Fish shell";

  # Configuration
  config.programs = lib.mkIf config.enableFish {
    # Keep using Bash as the system/login shell
    bash = {
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
    fish.enable = true;
  };
}
