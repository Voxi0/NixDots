{ pkgs, ... }: {
  # Services
  services = {
    # Touchpad support
    libinput.enable = true;

    # Display/Login manager
    displayManager.sddm = {
      enable = true;
      enableHidpi = true;
      theme = "tokyo-night-sddm";
      autoNumlock = true;
    };

    # X11 windowing system
    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];

      # Keymap
      xkb = {
        layout = "gb";
	    variant = "";
      };
    };

    # OpenSSH daemon
    openssh.enable = true;

    # Udisks2 to automount removable media
    udisks2.enable = true;

    # CUPS to print documents
    printing.enable = true;
  };
}
