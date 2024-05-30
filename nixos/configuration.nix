{ config, pkgs, ... }: {
  # Import Nix Modules
  imports = [ ./hardware-configuration.nix ];

  # Enable Experimental Features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Hardware Settings
  hardware = {
    # Enable/Disable Pulseaudio
    pulseaudio.enable = false;

    # Most Wayland Compositors Need This
    nvidia.modesetting.enable = true;

    # OpenGL
    opengl = {
      # Enable/Disable OpenGL
      enable = true;

      # DRI Support
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  # Bootloader
  boot.loader = {
    # UEFI Settings
    efi = {
      canTouchEfiVariables = true;
    };

    # GRUB
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
    };
  };

  # System Console Settings
  console = {
    keyMap = "uk";
  };

  # Networking
  networking = {
    # System Hostname
    hostName = "NixOS";

    # Network Manager to Manage Internet Connection
    networkmanager.enable = true;

    # Firewall
    firewall.enable = true;
  };

  # Time Zone and Internationalisation Properties
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
    # Required - To Manage Permissions
    polkit.enable = true;

	# Optional But Recommended - Disable RTKit (For Pipewire)
    rtkit.enable = true;
  };

  # Services
  services = {
    # Xserver - Xorg/X11
    xserver = {
      # Enable Xserver - Required For SDDM (Display/Login Manager)
      enable = true;

      # Keyboard Layout and Variant
      xkb.layout = "gb";
      xkb.variant = "";
    };
    
    # Display/Login Manager
    displayManager = {
      # Set Display Manager's Default Session
      defaultSession = "hyprland";

      # Enable SDDM
      sddm.enable = true;
    };

    # Pipewire - Sound
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # OpenSSH
    openssh.enable = true;
  };

  # Programs
  programs = {
    # Required For Hyprland to Show up as an Option in The Display Manager
    hyprland.enable = true;

    # Required to Use Fish Shell - Removing This Will Cause a Fatal Error When Rebuilding
    fish.enable = true;
  };

  # Users
  users.users = {
    # Voxi0 - Primary User
    voxi0 = {
      isNormalUser = true;
      description = "Wasiq Arbab";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.fish;
      packages = with pkgs; [];
    };
  };

  # Allow Unfree Software/Packages
  nixpkgs.config.allowUnfree = true;

  # XDG Desktop Portals
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Packages Installed on System - Available to All Uesrs
  environment.systemPackages = with pkgs; [];

  # Don't Change Unless You Really Know What You're Doing
  system.stateVersion = "23.11";
}
