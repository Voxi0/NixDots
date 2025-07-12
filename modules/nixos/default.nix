{ lib, config, locale, pkgs, ... }: {
	# Import Nix modules
	imports = [
		./hardware						# Hardware specific configuration e.g. graphics drivers
		./stylix.nix					# System-wide theming and typography
		./desktops/hyprland		# Desktop environment / Window manager
		./users.nix						# Configure user groups and such
		./services						# System services
		./programs.nix				# System programs
		./virtualization.nix	# Virtualization stuff e.g. KVM (Kernel-based Virtual Machine)
		./fish.nix						# Fancy shell
		./gaming.nix					# Gaming related stuff
	];

	# Module options
	options = {
		enableNetworking = lib.mkEnableOption "Enable networking";
		enableXdgPortals = lib.mkEnableOption "Enable XDG portals (Service that allows apps to interact with the desktop safely)";
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
				polkit.enable = true;
				rtkit.enable = true;
			};

			# Internationalisation properties
			i18n.defaultLocale = locale;

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
	];
}
