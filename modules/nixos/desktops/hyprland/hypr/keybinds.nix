{ pkgs, ... }: let
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
	wayland.windowManager.hyprland.settings = {
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
			"$mainMod CONTROL, M, exec, $toggleMicMuteCmd"

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

			# Miscellaneous
			",CAPSLOCK, exec, swayosd-client --caps-lock"
		] ++ (
			# Workspaces
			builtins.concatLists (builtins.genList
				(i: let ws = i + 1; in [
					"$mainMod, code:1${toString i}, workspace, ${toString ws}"
					"$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
				])
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
			",XF86AudioMicMute, exec, $toggleMicMuteCmd"

			# Playerctl - Control currently playing media
			",XF86AudioNext, exec, playerctl next"
			",XF86AudioPrev, exec, playerctl previous"
			",XF86AudioPause, exec, playerctl play-pause"
			",XF86AudioPlay, exec, playerctl play-pause"
		];

		bindm = [
			# Move/Resize window using `$mainMod + LMB/RMB` and dragging
			"$mainMod, mouse:272, movewindow"
			"$mainMod, mouse:273, resizewindow"
		];
	};
}
