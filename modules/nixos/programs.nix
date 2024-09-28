_: {
  # Programs
  programs = {
    # Some programs need SUID wrappers - Can be configured further or are started in user sessions
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    zsh.enable = true;      # Required to set ZSH as the default shell for the user
    hyprland.enable = true; # Required to ensure that Hyprland shows up in the display/login manager
  };
}
