{ lib, config, system, kbLayout, inputs, username, pkgs, ... }: let
	hyprlandPkgs = inputs.hyprland.packages.${system};
	hyprlandPluginsPkgs = inputs.hyprland-plugins.packages.${system};
in {
	# Hyprland NixOS module - Required as it enables critical components needed to run Hyprland properly
	programs.hyprland = {
		enable = true;
		withUWSM = true;
		package = hyprlandPkgs.hyprland;
		portalPackage = hyprlandPkgs.xdg-desktop-portal-hyprland;
	};

	# Udisks2 - D-Bus service to access and manipulate storage devices
	services.udisks2.enable = true;

	# Home Manager specific configuration
	home-manager.users.${username} = {
		# Import Home Manager modules
		imports = [ ./hypr ./apps ];

		# Required packages
		home.packages = with pkgs; [
			nwg-displays		# Manage monitors
			swww						# Efficient wallpaper daemon that supports animated wallpapers
			wl-clipboard		# System clipboard
			grim						# To take screenshots
			slurp						# To snip a part of the screen as selection
			feh							# Simple image viewer
		];

		# Services
		services = {
			# Polkit GUI authentication daemon
			hyprpolkitagent.enable = true;

			# Automounts removable drives using Udisks2
			udiskie.enable = true;

			# Shows a simple volume/brightness level bar
			swayosd = {
				enable = true;
				topMargin = 0.1;
			};
		};

		# XDG desktop portals - D-Bus service allowing apps to interact with the desktop safely
		xdg.portal = {
  		enable = true;
  		extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
		};

		# Hyprland
		wayland.windowManager.hyprland = {
			enable = true;
			package = hyprlandPkgs.hyprland;
			portalPackage = hyprlandPkgs.xdg-desktop-portal-hyprland;
			xwayland.enable = true;
			systemd.enable = false;
			plugins = with hyprlandPluginsPkgs; [];
			settings = {
				############
				### FEEL ###
				############
				general = {
					# Gap amount between windows / window and screen edge
					gaps_in = 5;
					gaps_out = 10;

					# Window borders
					border_size = 0;
					# "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
					# "col.inactive_border" = "rgba(595959aa)";

					# Enable/Disable resizing windows by clicking and dragging on borders and gaps
					resize_on_border = false;

					# See `https://wiki.hyprland.org/Configuring/Tearing/` before you turn this on
					allow_tearing = false;
				};

				#####################
				### MISCELLANEOUS ###
				#####################
				misc = {
					disable_hyprland_logo = true;
					force_default_wallpaper = false;
					vfr = true;
				};
			};
		};
	};
}
