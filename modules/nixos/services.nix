{ lib, config, kbLayout, pkgs, ... }: {
	# Services
  services = {
		libinput.enable = true; # Touchpad support
    blueman.enable = true;  # Bluetooth manager
    udisks2.enable = true;  # Auto-mounts removable media
    openssh.enable = true;  # Suite of secure networking utilities
    printing.enable = true; # CUPS to print documents
    fprintd.enable = true;  # Support for fingerprint reading devices

		# Abstraction layer for power management used by applications
    upower = {
      enable = true;
      usePercentageForPolicy = true; # Use battery percentage rather than time left
      percentageAction = 2;
      percentageCritical = 5;
      percentageLow = 10;
      allowRiskyCriticalPowerAction = false;
      criticalPowerAction = "PowerOff";
    };

    # X11 windowing system
    xserver = {
      enable = false;
			excludePackages = [ pkgs.xterm ];
			videoDrivers = lib.mkIf config.enableNvidia [ "nvidia" ];
      xkb = {
        layout = kbLayout;
        variant = "";
      };
    };

		# Pipewire - Audio
		pulseaudio.enable = false;
		pipewire = {
			enable = true;
			wireplumber.enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			jack.enable = true;
		};
  };
}
