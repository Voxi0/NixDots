{ ... }: {
  programs = {
    # Some programs need SUID wrappers - Can be configured further or are started in user sessions
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

		# Thunar file manager for XFCE
		thunar.enable = true;
		xfconf.enable = true;
  };
}
