{ pkgs, ... }: {
	# System-wide installed packages
	environment.systemPackages = with pkgs; [(
		# SDDM theme
		catppuccin-sddm.override {
			flavor = "mocha";
			font  = "JetBrainsMono Nerd Font";
			fontSize = "12";
			loginBackground = true;
		}
	)];

  # Services
  services = {
		# DBus
		dbus.enable = true;

		# Power
		upower.enable = true;
		acpid.enable = true;

    # Touchpad support
    libinput.enable = true;

    # Required for handling fingerprint authentications
    fprintd.enable = true;

    # Display/Login manager
    displayManager.sddm = {
      enable = true;
			package = pkgs.kdePackages.sddm;
			theme = "catppuccin-mocha";
      enableHidpi = true;
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

    # Bluetooth
    blueman.enable = true;

    # CUPS to print documents
    printing.enable = true;
  };
}
