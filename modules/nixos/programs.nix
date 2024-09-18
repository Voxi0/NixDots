_: {
  # Programs
  programs = {
    # Some programs need SUID wrappers - Can be configured further or are started in user sessions
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # ZSH - Must be enabled when using ZSH
    zsh.enable = true;

    # Hyprland - If not enabled, won't show up in login manager
    hyprland.enable = true;
  };
}
