{ inputs, username, pkgs, ... }: {
	# NVidia specific
	boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

	# Hyprland NixOS module - Required as it enables critical components needed to run Hyprland properly
	programs.hyprland = {
		enable = true;
		withUWSM = true;
		package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
		portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
	};

	# Home Manager specific configuration
	home-manager.users.${username} = {
		# Import Home Manager modules
		imports = [ ./hypr ./apps ];

		# Very handy packages
		home.packages = with pkgs; [
			hyprpolkitagent		# GUI authentication daemon
			nwg-displays			# Manage monitors
			swww							# Very efficient wallpaper daemon that supports animated wallpapers
			waypaper					# Simple GUI wallpaper picker
			wl-clipboard			# System clipboard
			grim							# Takes a screenshot
			slurp							# Allows user to snip a part of the screen for whatever
			feh								# Simple image viewer
			udiskie						# Automatically mounts and manages external storage
		];

		# Services
		services = {
			# To control active media players via the CLI
			playerctld.enable = true;

			# On Screen Display (OSD) - Shows a simple volume/brightness level bar
			swayosd = {
				enable = true;
				topMargin = 0.1;
			};
		};

		# Hyprland
		wayland.windowManager.hyprland = {
			enable = true;
			xwayland.enable = true;
			systemd.enable = false;
			plugins = with inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}; [];
			settings = {
				general = {
					# Gap amount between windows / window and screen edge
					gaps_in = 5;
					gaps_out = 10;

					# Window borders
					border_size = 0;
					# "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
					# "col.inactive_border" = "rgba(595959aa)";

					# Enable/Disable resizing windows by clicking and dragging on their borders and gaps
					resize_on_border = false;

					# Please see `https://wiki.hyprland.org/Configuring/Tearing` before you turn this on
					allow_tearing = false;

					# Default window layout
					layout = "dwindle";
				};

				# Miscallaneous config
				misc = {
					disable_hyprland_logo = true;
					force_default_wallpaper = false;
					
					# Lower the amount of frames sent when nothing is happening onscreen to improve performance
					vfr = true;
				};
			};
		};
	};
}
