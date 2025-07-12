{ lib, config, pkgs, ... }: {
  # Module options
  options.enableFish = lib.mkEnableOption "Enable Fish shell";

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
	};
}
