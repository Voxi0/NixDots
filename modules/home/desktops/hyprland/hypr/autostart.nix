{
  lib,
  config,
  pkgs,
  ...
}: {
  #################
  ### AUTOSTART ###
  #################
  wayland.windowManager.hyprland.settings.exec-once = [
    "uwsm app -- quickshell"
    "uwsm app -- swww-daemon"
    "swww restore"
    "uwsm app -- swaync"
    (lib.optionals (pkgs ? mpdscribble) "uwsm app -- mpdscribble")
  ];
}
