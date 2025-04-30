{ inputs, systemDisk, pkgs, hostname, username, keymap, timezone, locale, ... }: {
  # Import Nix modules	
  imports = [
		inputs.NixDotsHyprland.nixosModules.default
    ./../../hardware-configuration.nix
    (import ../../disko.nix { device = systemDisk; })
    ./../../modules/nixos
  ];
  
  # Enable/Disable our custom system modules
	enableIntel = true;
	enableNVidia = false;
	enableSecureBoot = true;	# Lanzaboote for secure boot
  enableStylix = true;      # System-wide theming and typography
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
    rtkit.enable = true;  # Optional, but recommended
    polkit.enable = true; # Required
  };

  # Boot
  boot = {
    # Kernel
    kernelPackages = pkgs.linuxPackages_latest;

    # Bootloader
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  # Console
  console.keyMap = keymap;

  # Time zone and locales
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
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Systemwide packages
  environment.systemPackages = with pkgs; [ pavucontrol networkmanagerapplet ];

  # Perfectly fine and recommended to not change this
  system.stateVersion = "24.11";
}
