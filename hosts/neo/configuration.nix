{ system, hostname, username, timezone, locale, kbLayout, config, inputs, pkgs, ... }: {
  # Import Nix modules
  imports = [
		inputs.NixDotsHyprland.nixosModules.default
		./../../hardware-configuration.nix
		./../../modules/nixos
	];

	# Enable the Hyprland cachix to avoid rebuilding large software from scratch
	nix.settings = {
		substituters = [ "https://hyprland.cachix.org" ];
		trusted-substituters = [ "https://hyprland.cachix.org" ];
		trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
	};

	# Enable/Disable our custom system modules
	enableIntel = true;
	enableNvidia = false;
	enableStylix = true;
  enableFish = true;
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

  # Bootloader
  boot = {
		kernelPackages = pkgs.linuxPackages_latest;
		kernelParams = [ ];
		extraModulePackages = with config.boot.kernelPackages; [ ];
		kernelModules = [ ];
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

	# Users - Remember to set a password with `passwd`
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
