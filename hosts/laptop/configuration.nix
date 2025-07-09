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
	enableAndroid = false;
	enableVirtualization = true;
  gaming = {
    enable = false;
    enableSteam = false;
    enableRoblox = false;
    enableLutris = false;
    enableHeroic = false;
  };

	# Services
	enableX11 = false;
	enableAudio = true;
	enableBluetooth = true;
	enableLaptopSupport = true;
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
    hostName = "NixOS-Laptop";
    networkmanager.enable = true;
    firewall.enable = true;
  };

	# System-wide packages
  environment.systemPackages = with pkgs; [ pavucontrol networkmanagerapplet kdePackages.k3b dvdplusrwtools ];

  # Unnecessary to change this value
  system.stateVersion = "25.05";
}
