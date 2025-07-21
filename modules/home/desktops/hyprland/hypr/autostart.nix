{
  lib,
  pkgs,
  ...
}: {
  #################
  ### AUTOSTART ###
  #################
  wayland.windowManager.hyprland.settings.exec-once = lib.concatLists [
		(lib.mkIf (pkgs ? mpdscribble) [ "uwsm app -- mpdscribble" ])
		[
			"uwsm app -- quickshell"
			"uwsm app -- swww-daemon"
			"swww restore"
			"uwsm app -- swaync"
		]
  ];
}
