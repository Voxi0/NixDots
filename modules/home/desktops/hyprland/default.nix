{ kbLayout, inputs, pkgs, ... }: {
	# Import Home Manager modules
	imports = [ ./apps ];

	# Home
	home = {
		# Base/Required packages
		packages = with pkgs; [
			hyprpolkitagent	# Polkit GUI authentication daemon
			nwg-displays		# Manage monitors
			swww						# Efficient wallpaper daemon that supports animated wallpapers
			wl-clipboard		# System clipboard
			grim						# To take screenshots
			slurp						# To snip a part of the screen as selection
			feh							# Simple image viewer
			udiskie					# Automatically mounts and manages removable media
		];
	};

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

	# XDG desktop portals
	xdg.portal = {
		enable = true;
		extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
	};

	# Hyprland
	wayland.windowManager.hyprland = let
		# Total number of workspaces to generate keybinds for
		numWorkspaces = 10;

		# Scripts for Hyprland
		# Playerctl toggle shuffle
		playerctlShuffleToggle = pkgs.writeShellScriptBin "playerctlShuffleToggle" ''
			#!/bin/sh
			playerctl shuffle toggle
			notify-send "Playerctl Shuffle" "$(playerctl shuffle)"
		'';

		# Toggle between the 3 playerctl loop modes - "None", "Track" and "Playlist"
		playerctlLoopToggle = pkgs.writeShellScriptBin "playerctlLoopToggle" ''
			#!/bin/sh

			# Get the current loop state
			currentState=$(playerctl loop)

			# Cycle through the states: "None", "Track", "Playlist"
			if [ "$currentState" = "None" ]; then
				playerctl loop track
				notify-send "Playerctl Loop" "Track"
			elif [ "$currentState" = "Track" ]; then
				playerctl loop playlist
				notify-send "Playerctl Loop" "Playlist"
			else
				playerctl loop none
				notify-send "Playerctl Loop" "None"
			fi
		'';
	in {
		enable = true;
		xwayland.enable = true;
		systemd.enable = false;
		plugins = with inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}; [];
		settings = {
			#############################
			### ENVIRONMENT VARIABLES ###
			#############################
			env = [
				# Set to "1" if the cursor keeps disappearing
				"WLR_NO_HARDWARE_CURSORS,0"

				# Use Wayland
				"NIXOS_OZONE_WL,1"
				"QT_QPA_PLATFORM,wayland"
				"GTK_USE_PORTAL,1"
				"MOZ_ENABLE_WAYLAND,1"
				"GDK_BACKEND,wayland"
				"SDL_VIDEODRIVER,wayland"
			];

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

			#################
			### AUTOSTART ###
			#################
			exec-once = [
				"systemctl --user enable --now hyprpolkitagent.service"
				"uwsm app -- swww-daemon"
				"swww restore"
				"uwsm app -- quickshell"
				"uwsm app -- udiskie --automount --smart-tray --terminal=$terminal"
				"uwsm app -- swaync"
				(lib.optionalString (pkgs ? mpdscribble) "uwsm app -- mpdscribble")
			];

			#############
			### INPUT ###
			#############
			input = {
				# Keyboard
				kb_layout = kbLayout;
				# kb_variant =
				# kb_model =
				# kb_options =
				# kb_rules =
				numlock_by_default = true;
				follow_mouse = 1;

				# Mouse acceleration
				sensitivity = 0;

				# Touchpad
				touchpad.natural_scroll = false;
			};

			# Touchpad gestures
			gestures = {
				workspace_swipe = true;
				workspace_swipe_forever = true;
			};

			##############################
			### WINDOWS AND WORKSPACES ###
			##############################
			windowrulev2 = [
				# Ignore maximize requests from apps. You'll probably like this.
				"suppressevent maximize, class:.*"

				# Fix some dragging issues with XWayland
				"nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
			];

			# Window layouts
			master.new_status = "master";
			dwindle = {
				# Master switch for pseudotiling - Enable with `mainMod + P`
				pseudotile = true;
				preserve_split = true;
			};

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

				# Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
				allow_tearing = false;

				# Default window layout
				layout = "dwindle";
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

			###################
			### KEYBINDINGS ###
			###################
			bind = [
				# Basics
				"$mainMod, RETURN, exec, $terminal"
				"$mainMod, D, exec, $menu"
				"$mainMod, F, fullscreen"
				"$mainMod, V, togglefloating"
				"$mainMod, Q, killactive"
				"$mainMod CONTROL, N, exec, swaync-client -t -sw"
				"$mainMod SHIFT, E, exec, $logoutMenuCmd"

				# Brightness
				"$mainMod CONTROL, Up, exec, $increaseBrightnessCmd"
				"$mainMod CONTROL, Down, exec, $decreaseBrightnessCmd"

				# Volume
				"$mainMod SHIFT, Up, exec, $increaseVolumeCmd"
				"$mainMod SHIFT, Down, exec, $decreaseVolumeCmd"
				"$mainMod SHIFT, M, exec, $toggleAudioMuteCmd"

				# Screenshot
				"$mainMod SHIFT, Insert, exec, $fullscreenScreenshotCmd"
				"$mainMod CONTROL, Insert, exec, $selectedAreaScreenshotCmd"

				# Playerctl - Mpris media player command-line controller
				"$mainMod SHIFT, N, exec, playerctl next"
				"$mainMod SHIFT, P, exec, playerctl previous"
				"$mainMod SHIFT, SPACE, exec, playerctl play-pause"
				"$mainMod SHIFT, Right, exec, playerctl position 10+"
				"$mainMod SHIFT, Left, exec, playerctl position 10-"
				"$mainMod SHIFT, S, exec, ${playerctlShuffleToggle}/bin/playerctlShuffleToggle"
				"$mainMod SHIFT, L, exec, ${playerctlLoopToggle}/bin/playerctlLoopToggle"

				# Window layout specific binds
				# Dwindle
				"$mainMod, P, pseudo"
				"$mainMod, J, togglesplit"

				# Move window focus around using $mainMod key and arrow keys
				"$mainMod, left, movefocus, l"
				"$mainMod, right, movefocus, r"
				"$mainMod, up, movefocus, u"
				"$mainMod, down, movefocus, d"

				# Scroll through existing workspaces using $mainMod key and scroll
				"$mainMod, mouse_down, workspace, e+1"
				"$mainMod, mouse_up, workspace, e-1"
			] ++ (
				# Workspaces
				builtins.concatLists (
					builtins.genList (
						i: let ws = i + 1; in [
							"$mainMod, code:1${toString i}, workspace, ${toString ws}"
							"$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
						]
					)
				numWorkspaces)
			);

			bindel = [
				# Brightness
				",XF86MonBrightnessUp, exec, $increaseBrightnessCmd"
				",XF86MonBrightnessDown, exec, $decreaseBrightnessCmd"

				# Volume - For media keys
				",XF86AudioRaiseVolume, exec, $increaseVolumeCmd"
				",XF86AudioLowerVolume, exec, $decreaseVolumeCmd"
				",XF86AudioMute, exec, $toggleAudioMuteCmd"

				# Playerctl - Mpris media player command-line controller
				",XF86AudioNext, exec, playerctl next"
				",XF86AudioPrev, exec, playerctl previous"
				",XF86AudioPause, exec, playerctl play-pause"
				",XF86AudioPlay, exec, playerctl play-pause"
			];

			bindm = [
				# Move/Resize window using $mainMod key, LMB/RMB and dragging
				"$mainMod, mouse:272, movewindow"
				"$mainMod, mouse:273, resizewindow"
			];
		};
	};
}
