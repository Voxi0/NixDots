{ system, username, timezone, locale, kbLayout, config, inputs, pkgs, ... }: {
  # Import Nix modules
  imports = [
		./hardware-configuration.nix
		./../../modules/nixos
	];

	# Enable the Hyprland cachix to avoid rebuilding large software from scratch
	nix.settings = {
		substituters = [ "https://hyprland.cachix.org" ];
		trusted-substituters = [ "https://hyprland.cachix.org" ];
		trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
	};

	# Enable/Disable our custom system modules
	enableGraphics = true;
	enableGraphics32Bit = true;
	enableIntel = true;
	enableNvidia = false;
	enableStylix = true;
  enableFish = true;
	enableAndroid = true;
	enableVirtualization = true;
  gaming = {
    enable = true;
    enableSteam = true;
    enableRoblox = true;
    enableLutris = false;
    enableHeroic = false;
  };

	# Services
	enableX11 = false;
	enableAudio = true;
	enableBluetooth = true;
	enableLaptopSupport = false;
	enableSSH = true;
	enablePrinting = false;
	enableFingerprint = false;

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
    hostName = "NixOS-Desktop";
    networkmanager.enable = true;
    firewall.enable = true;
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
