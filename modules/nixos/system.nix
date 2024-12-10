{ pkgs, ... }: {
  # Hardware
  hardware = {
    graphics.enable = true;
    bluetooth.enable = true;
  };

  # Console
  console.keyMap = "uk";

  # Boot
  boot = {
		kernelPackages = pkgs.linuxPackages_latest;
		kernelModules = [ "acpi" ];
		loader = {
			# EFI and SystemD boot
			efi.canTouchEfiVariables = true;
			systemd-boot.enable = true;
		};
	};

  # Time zone and internationalisation properties
  time.timeZone = "Europe/London";
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  # Security
  security = {
    polkit.enable = true;
    rtkit.enable = true;      # Optional but recommended
		pam.services.hyprlock = {};
  };

  # Systemwide packages - Available to all users
  environment.systemPackages = [ ];

  # Determines the NixOS release from which the default settings for stateful data on your system were taken
  # Perfectly fine and recommended to leave this value at the release version of the first install of this system
  # Before changing this value, read the docs for this option
  system.stateVersion = "24.05";
}
