{ systemDisk, pkgs, hostname, username, keymap, timezone, locale, xkbLayout, ... }: {
  # Import Nix modules	
  imports = [
    ./../../hardware-configuration.nix
    (import ../../disko.nix { device = systemDisk; })
    ./../../modules/nixos
		./../../modules/nixos/lanzaboote.nix
  ];
  
  # Enable/Disable our custom system modules
	enableSecureBoot = true;	# Lanzaboote for secure boot
  enableStylix = true;      # System-wide theming and typography
	enableHyprland = true;
  enableSway = false;
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

  # Services
  services = {
    libinput.enable = true; # Touchpad support
    blueman.enable = true;  # Bluetooth manager
    udisks2.enable = true;  # Automounts removable media
    openssh.enable = true;  # Suite of secure networking utilities
    printing.enable = true; # CUPS to print documents
    fprintd.enable = true;  # Support for fingerprint reading devices

    # Abstraction layer for power management that can be used by applications
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
      xkb = {
        layout = xkbLayout;
	      variant = "";
      };
    };

    # Pipewire
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
	      support32Bit = true;
      };
    };
  };

  # Users - Don't forget to set a password with `passwd`
  users.users.${username} = {
    isNormalUser = true;
    initialPassword = "nixos";
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Fonts
  fonts.fontDir.enable = true;

  # Programs
  programs = {
    # Some programs need SUID wrappers - Can be configured further or are started in user sessions
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # Systemwide packages
  environment.systemPackages = with pkgs; [ pavucontrol networkmanagerapplet ];

  # Perfectly fine and recommended to not change this
  system.stateVersion = "24.11";
}
