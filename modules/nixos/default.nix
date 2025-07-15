{ lib, config, locale, username, pkgs, ... }: {
	# Import Nix modules
	imports = [
		./hardware.nix				# Hardware specific configuration e.g. graphics drivers
		./services.nix				# System services
		./stylix.nix					# System-wide theming and typography
		./desktops/hyprland		# Desktop environment / Window manager
		./fish.nix						# Fancy shell
		./gaming.nix					# Gaming related stuff
	];

	# Module options
	options = {
		enableNetworking = lib.mkEnableOption "Enable networking";
		enableXdgPortals = lib.mkEnableOption "Enable XDG portals (Service that allows apps to interact with the desktop safely)";
		enableVirtualization = lib.mkEnableOption "Enable virtualization support";
	};

	# Configuration
	config = lib.mkMerge [
		# No conditions used here
		{
			# Boot
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

			# Security
			security = {
				polkit.enable = true;	# Controls system-wide privileges - Necessary for authentication
				rtkit.enable = true;	# Make Pipewire realtime capable - Optional but recommended
			};

			# Internationalisation properties
			i18n.defaultLocale = locale;

			# Users - Remember to set a password with `passwd`
			users.users.${username} = {
				isNormalUser = true;
				initialPassword = "nixos";
				description = "${username}";
				extraGroups = [ "networkmanager" "wheel" "cdrom" ];
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
			environment.systemPackages = [ pkgs.networkmanagerapplet ];
			networking = {
				hostName = "NixOS-Desktop";
				networkmanager.enable = true;
				firewall.enable = true;
			};
		})

		# XDG desktop portals
		(lib.mkIf config.enableXdgPortals {
			xdg.portal = {
				enable = true;
				extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
			};
		})

		# Virtualization
		(lib.mkIf config.enableVirtualization {
			users.users.${username}.extraGroups = [ "kvm" "libvirtd" ];
			virtualisation = {
				libvirtd.enable = true;				# Abstraction layer to manage virtual machines
				vmVariant.virtualisation = {
					graphics = true;						# Run QEMU in a graphics window
					cores = 2;									# Number of cores the guest is permitted to use
				};
			};
		})
	];
}
