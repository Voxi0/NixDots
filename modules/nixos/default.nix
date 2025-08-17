{
  lib,
  config,
  locale,
  hostname,
  username,
  pkgs,
  ...
}: {
  # Import Nix modules
  imports = [
    ./hardware.nix # Hardware specific configuration e.g. graphics drivers
    ./services.nix # System services
    ./laptop.nix # Laptop support stuff e.g. battery optimizations
    ./plymouth.nix # Graphical splash screen during boot/poweroff
    ./desktops # Desktop environments and window managers
    ./fish.nix # Fancy shell
    ./gaming.nix # Gaming related stuff
  ];

  # Module options
  options = {
    enableNetworking = lib.mkEnableOption "Enable networking";
    enableVirtualization = lib.mkEnableOption "Enable virtualization support e.g. QEMU";
  };

  # Configuration
  config = lib.mkMerge [
    # No conditions used here
    {
      # Nix
      nix = {
        optimise.automatic = true;
        settings = {
          trusted-users = ["root" "${username}"];
          experimental-features = ["nix-command" "flakes"];
          auto-optimise-store = true;
        };
      };

      # Console
      console.font = "Lat2-Terminus16";

      # Boot
      boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        tmp.cleanOnBoot = true;
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
      };

      # Security
      security = {
        polkit.enable = true; # Controls system-wide privileges - Necessary for authentication
        rtkit.enable = true; # Make Pipewire realtime capable - Optional but recommended
      };

      # Internationalisation properties
      i18n.defaultLocale = locale;

      # Users - Remember to set a password with `passwd`
      users.users.${username} = {
        isNormalUser = true;
        initialPassword = "nixos";
        description = "${username}";
        extraGroups = ["networkmanager" "wheel" "input"];
      };

      # Some programs need SUID wrappers - Can be configured further or are started in user sessions
      programs = {
        mtr.enable = true;
        gnupg.agent = {
          enable = true;
          enableSSHSupport = true;
        };
      };

      # Don't change this value
      system.stateVersion = "25.05";
    }

    # Networking
    (lib.mkIf config.enableNetworking {
      programs.nm-applet.enable = true;
      networking = {
        hostName = hostname;
        networkmanager.enable = true;
        firewall.enable = true;
      };
    })

    # Virtualization
    (lib.mkIf config.enableVirtualization {
      users.users.${username}.extraGroups = ["kvm" "libvirtd"];
      virtualisation = {
        libvirtd.enable = true; # Abstraction layer to manage virtual machines
        vmVariant.virtualisation = {
          # Run QEMU in a graphical window
          graphics = true;

          # Number of cores that the virtual machine can use
          cores = 2;
        };
      };
    })
  ];
}
