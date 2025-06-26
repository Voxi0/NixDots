{ lib, pkgs, ... }: {
	wayland.windowManager.hyprland.settings = {
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
			(lib.mkIf (pkgs.mpdscribble != null) "uwsm app -- mpdscribble")
		];
	};
}
