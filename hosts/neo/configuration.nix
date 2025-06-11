{ systemDisk, system, hostname, username, timezone, locale, keymap, config, pkgs, ... }: {
  # Import Nix modules
  imports = [
		# (import ../../disko.nix { device = systemDisk; })
		./../../hardware-configuration.nix
		./../../modules/nixos
	];

	# Enable/Disable our custom system modules
	enableIntel = true;
	enableNvidia = false;
	enableStylix = true;
  enableFish = true;        # Fish shell (Not POSIX compliant)
  gaming = {
    enable = true;
    enableSteam = true;
    enableRoblox = true;
    enableLutris = false;
    enableHeroic = false;
  };

	# Security
	security = {
		polkit.enable = true;	# Required
		rtkit.enable = true;	# Optional but recommended
	};

  # Configure console keymap
  console.keyMap = keymap;

  # Bootloader
  boot = {
		kernelPackages = pkgs.linuxPackages_latest;
		kernelParams = [ ];
		loader = {
    	systemd-boot.enable = true;
    	efi.canTouchEfiVariables = true;
  	};
	};

  # Timezone and internationalisation properties
  time.timeZone = timezone;
  i18n.defaultLocale = locale;

	# Networking
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    firewall.enable = true;
  };

	# Users - Don't forget to set a password with `passwd`
  users.users.${username} = {
    isNormalUser = true;
    initialPassword = "nixos";
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" "cdrom" ];
  };

	# XDG desktop portals
	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
	};

	# System-wide packages
  environment.systemPackages = with pkgs; [ pavucontrol networkmanagerapplet kdePackages.k3b dvdplusrwtools ];

  # Unnecessary to change this value
  system.stateVersion = "25.05";
}
