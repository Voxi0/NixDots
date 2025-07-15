{ lib, config, kbLayout, inputs, username, pkgs, ... }: {
	# Hyprland NixOS module - Required as it enables critical components needed to run Hyprland properly
	programs.hyprland = {
		enable = true;
		withUWSM = true;
		package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
		portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
	};

	# Udisks2 - D-Bus service to access and manipulate storage devices
	services.udisks2.enable = true;

	# Home Manager specific configuration
	home-manager.users.${username} = {
		# Import Home Manager modules
		imports = [ ./hypr ./apps ];

		# Required packages
		home.packages = with pkgs; [
			hyprpolkitagent	# Polkit GUI authentication daemon
			nwg-displays		# Manage monitors
			swww						# Efficient wallpaper daemon that supports animated wallpapers
			wl-clipboard		# System clipboard
			grim						# To take screenshots
			slurp						# To snip a part of the screen as selection
			feh							# Simple image viewer
		];

		# Services
		services = {
			udiskie.enable = true;		# To automount removable drives using Udisks2

			# On Screen Display (OSD) - Shows a simple volume/brightness level bar
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
			xwayland.enable = true;
			systemd.enable = false;
			plugins = with inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}; [];
			settings = {
				#################
				### VARIABLES ###
				#################
				"$mainMod" = "SUPER";
				"$terminal" = "uwsm app -- kitty";
				"$menu" = "uwsm app -- $(wofi --show drun --define=drun-print_desktop_file=true)";

				# Command to bring up the logout menu
				"$logoutMenuCmd" = "uwsm app -- wlogout";

				# Commands to control volume
				"$increaseVolumeCmd" = "swayosd-client --output-volume +5 --max-volume 100";
				"$decreaseVolumeCmd" = "swayosd-client --output-volume -5 --max-volume 100";
				"$toggleAudioMuteCmd" = "swayosd-client --output-volume mute-toggle";

				# Commands to control screen brightness
				"$increaseBrightnessCmd" = "swayosd-client --brightness +5";
				"$decreaseBrightnessCmd" = "swayosd-client --brightness -5";

				# Commands to use for screenshots - For the entire screen or selected area
				"$fullscreenScreenshotCmd" = "grim";
				"$selectedAreaScreenshotCmd" = ''grim -g "$(slurp)"'';

				#####################
				### LOOK AND FEEL ###
				#####################
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

					# Please see `https://wiki.hyprland.org/Configuring/Tearing/` before you turn this on
					allow_tearing = false;
				};
				decoration = {
					# Radius of rounded window corners
					rounding = 6;

					# Transparency of focused/unfocused windows
					active_opacity = 1.0;
					inactive_opacity = 1.0;

					# Drop shadow
					shadow = {
						enabled = true;
						range = 4;
						render_power = 3;
					};

					# Blur
					blur = {
						enabled = true;
						size = 3;
						passes = 1;
						vibrancy = 0.1696;
					};
				};
				animations = {
					enabled = true;
					bezier = [
						"easeOutQuint,0.23,1,0.32,1"
						"easeInOutCubic,0.65,0.05,0.36,1"
						"linear,0,0,1,1"
						"almostLinear,0.5,0.5,0.75,1.0"
						"quick,0.15,0,0.1,1"
					];
					animation = [
						"global, 1, 10, default"
						"border, 1, 5.39, easeOutQuint"

						"windows, 1, 4.79, easeOutQuint"
						"windowsIn, 1, 4.1, easeOutQuint, popin 87%"
						"windowsOut, 1, 1.49, linear, popin 87%"

						"fade, 1, 3.03, quick"
						"fadeIn, 1, 1.73, almostLinear"
						"fadeOut, 1, 1.46, almostLinear"

						"layers, 1, 3.81, easeOutQuint"
						"layersIn, 1, 4, easeOutQuint, fade"
						"layersOut, 1, 1.5, linear, fade"

						"fadeLayersIn, 1, 1.79, almostLinear"
						"fadeLayersOut, 1, 1.39, almostLinear"

						"workspaces, 1, 1.94, almostLinear, fade"
						"workspacesIn, 1, 1.21, almostLinear, fade"
						"workspacesOut, 1, 1.94, almostLinear, fade"
					];
				};

				# Miscallaneous config
				misc = {
					disable_hyprland_logo = true;
					force_default_wallpaper = false;

					# Lower the amount of frames sent when nothing is happening on-screen to improve performance
					vfr = true;
				};
			};
		};
	};
}
