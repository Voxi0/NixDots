{ pkgs, hostname, username, ... }: {
  # Import Nix modules	
  imports = [
    ./../../hardware-configuration.nix
    ./../../modules/nixos
  ];
  
  # Enable NixOS modules
  enableStylix = true;      # System-wide theming and typography
  enableFish = true;        # Fish shell (Not POSIX compliant)

  # Enable window managers / desktop environments
  enableHyprland = true;
  enableSway = false;

  # Hardware
  hardware = {
    bluetooth.enable = true;           # Bluetooth

    # Enable all firmware regardless of license and support for most hardware
    enableAllFirmware = true;
    enableAllHardware = true;

    # Graphics
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        # For hardware video acceleration
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (Older but works better for Firefox/Chromium)
        libvdpau-va-gl
      ];
    };

    # Nvidia
    nvidia = {
      open = false;                   # Use proprietary drivers
      modesetting.enable = true;      # Most Wayland compositors requires this
      powerManagement.enable = true;  # For Hyprland on Nvidia
    };
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
    kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ]; # For Hyprland on Nvidia

    # Bootloader
    loader = {
      # EFI
      efi.canTouchEfiVariables = true;

      # SystemD Boot
      systemd-boot.enable = true;
    };
  };

  # Console
  console.keyMap = "uk";

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
        layout = "gb";
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
