{ lib, pkgs, ... }: {
	#################
	### AUTOSTART ###
	#################
	wayland.windowManager.hyprland.settings.exec-once = [
		"uwsm app -- hyprpolkitagent"
		"uwsm app -- swww-daemon"
		"swww restore"
		"uwsm app -- quickshell"
		"uwsm app -- swaync"
		(lib.optionalString (pkgs ? mpdscribble) "uwsm app -- mpdscribble")
	];
}
