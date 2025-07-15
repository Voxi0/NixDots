{ pkgs, ... }: let
	# Toggle shuffle
	playerctlShuffleToggle = pkgs.writeShellScriptBin "playerctlShuffleToggle" ''
		playerctl shuffle toggle
		notify-send "Playerctl Shuffle" "$(playerctl shuffle)"
	'';

	# Toggle between the 3 loop modes - "None", "Track" and "Playlist"
	playerctlLoopToggle = pkgs.writeShellScriptBin "playerctlLoopToggle" ''
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
	# Player controller daemon - To control active media players via the CLI
	services.playerctld.enable = true;
	wayland.windowManager.hyprland.settings = {
		bind = builtins.concatLists [
			[
				# Playerctl - Mpris media player command-line controller
				"$mainMod SHIFT, N, exec, playerctl next"
				"$mainMod SHIFT, P, exec, playerctl previous"
				"$mainMod SHIFT, SPACE, exec, playerctl play-pause"
				"$mainMod SHIFT, Right, exec, playerctl position 10+"
				"$mainMod SHIFT, Left, exec, playerctl position 10-"
				"$mainMod SHIFT, S, exec, ${playerctlShuffleToggle}/bin/playerctlShuffleToggle"
				"$mainMod SHIFT, L, exec, ${playerctlLoopToggle}/bin/playerctlLoopToggle"
			]
		];
		bindel = builtins.concatLists [
			[
				# Playerctl - Mpris media player command-line controller
				",XF86AudioNext, exec, playerctl next"
				",XF86AudioPrev, exec, playerctl previous"
				",XF86AudioPause, exec, playerctl play-pause"
				",XF86AudioPlay, exec, playerctl play-pause"
			]
		];
	};
}
