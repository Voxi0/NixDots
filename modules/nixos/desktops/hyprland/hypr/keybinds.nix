_: let
  # Total number of workspaces to generate keybinds for
  numWorkspaces = 10;
in {
  wayland.windowManager.hyprland.settings = {
    #################
    ### VARIABLES ###
    #################
    "$mainMod" = "SUPER";
    "$terminal" = "uwsm app -- kitty";
    "$menu" = "pidof wofi || uwsm app -- $(wofi --show drun)";

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

    ###################
    ### KEYBINDINGS ###
    ###################
    bind =
      [
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
      ]
      ++ (
        # Workspaces
        builtins.concatLists (
          builtins.genList (
            i: let
              ws = i + 1;
            in [
              "$mainMod, code:1${toString i}, workspace, ${toString ws}"
              "$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          numWorkspaces
        )
      );

    bindel = [
      # Brightness
      ",XF86MonBrightnessUp, exec, $increaseBrightnessCmd"
      ",XF86MonBrightnessDown, exec, $decreaseBrightnessCmd"

      # Volume - For media keys
      ",XF86AudioRaiseVolume, exec, $increaseVolumeCmd"
      ",XF86AudioLowerVolume, exec, $decreaseVolumeCmd"
      ",XF86AudioMute, exec, $toggleAudioMuteCmd"
    ];

    bindm = [
      # Move/Resize window using $mainMod key, LMB/RMB and dragging
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
  };
}
