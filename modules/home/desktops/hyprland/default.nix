{ inputs, pkgs, ... }: {
  # Import Nix modules
  imports = [
    ./apps
  ];

  # Home
  home = {
    # Base/Required packages
    packages = with pkgs; [
      # Base
      hyprpolkitagent inputs.swww.packages.${pkgs.system}.swww libnotify
      libsForQt5.qt5.qtwayland kdePackages.qtwayland qt6Packages.qt6ct

      # Utilities
      pamixer brightnessctl playerctl grim slurp feh udiskie hyprwall hyprshade
    ];

    # Scripts for Hyprland
    file = {
      # Toggle shuffle
      ".config/hypr/scripts/playerctl-shuffle-toggle" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash

          # Get the current shuffle state
          currentState=$(playerctl shuffle)

          if [ "$currentState" = "On" ]; then
            playerctl shuffle off
            notify-send "Playerctl Shuffle" "Off"
          else
            playerctl shuffle on
            notify-send "Playerctl Shuffle" "On"
          fi

          wait $notificationID
        '';
      };

      # There's 3 loop modes, this script toggles between each - "None", "Track" and "Playlist"
      ".config/hypr/scripts/playerctl-loop-toggle" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash

          # Get the current loop state
          currentState=$(playerctl loop)

          # Cycle through the states: "None", "Track", "Playlist"
          if [ "$currentState" = "None" ]; then
              playerctl loop Track
              notify-send "Playerctl Loop" "Track"
          elif [ "$currentState" = "Track" ]; then
              playerctl loop Playlist
              notify-send "Playerctl Loop" "Playlist"
          else
              playerctl loop None
              notify-send "Playerctl Loop" "None"
          fi
        '';
      };
    };
  };

  # Playerctl
  services.playerctld = {
    enable = true;
    package = pkgs.playerctl;
  };

  # Stop Stylix from using Hyprpaper to set the wallpaper - We want to use SWWW for wallpapers instead
  stylix.targets = {
    hyprland.enable = false;  # Must be disabled in order to disable Hyprpaper without any conflicts
    hyprpaper.enable = false;
  };

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
		xwayland.enable = true;
		systemd.enable = false;
		package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    plugins = with inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}; [
		];
    settings = {
      ################
      ### MONITORS ###
      ################
      "monitor" = ",preferred,auto,auto";
      #############################
      ### ENVIRONMENT VARIABLES ###
      #############################
      env = [
        "NIXOS_OZONE_WL,1"
        "QT_QPA_PLATFORM,wayland"
      ];
      #################
      ### VARIABLES ###
      #################
      "$mainMod" = "ALT";
      "$terminal" = "kitty";
      "$menu" = "wofi --show drun";

      #################
      ### AUTOSTART ###
      #################
      exec-once = [
        "swww-daemon && swww restore"
        "ags run"
        "udiskie --automount --smart-tray --terminal=$terminal"
        "hyprshade on vibrance"
      ];

      #############
      ### INPUT ###
      #############
      input = {
        # Keyboard
        kb_layout = "gb";
        # kb_variant =
        # kb_model =
        # kb_options =
        # kb_rules =
        numlock_by_default = true;
        follow_mouse = 1;

        # Mouse acceleration
        sensitivity = 0;

        # Touchpad
        touchpad = {
            natural_scroll = true;
        };
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
      dwindle = {
        # Master switch for pseudotiling. Enabling is bound to mainMod + P
        pseudotile = true;
        preserve_split = true;                 # You probably want this
      };
      master = {
        new_status = "master";
      };

      #####################
      ### LOOK AND FEEL ###
      #####################
      general = {
        # Gap amount between windows / between window and screen edge
        gaps_in = 5;
        gaps_out = 10;

        # Window borders
        border_size = 0;
        # "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        # "col.inactive_border" = "rgba(595959aa)";

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false;

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        # Window layout style to use
        layout = "dwindle";
      };

      decoration = {
        # Radius of rounded window corners
        rounding = 2;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        # Enable/Disable animations
        enabled = true;

        # Default animations
        # Beziers
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        # Animations
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
        vfr = true;                            # Lowers the amount of sent frames when nothing is happening on-screen
      };

      ################
      ### COMMANDS ###
      ################
      # Commands to control volume
      "$increaseVolumeCmd" = "pamixer -i 5";
      "$decreaseVolumeCmd" = "pamixer -d 5";
      "$toggleAudioMuteCmd" = "pamixer --toggle-mute";
      "$toggleMicMuteCmd" = "pamixer --default-source -t";

      # Commands to control screen brightness
      "$increaseBrightnessCmd" = "brightnessctl s +5%";
      "$decreaseBrightnessCmd" = "brightnessctl s 5%-";

      # Commands to use for screenshots - For the entire screen or selected area
      "$fullscreenScreenshotCmd" = "grim";
      "$selectedAreaScreenshotCmd" = "grim -g '$(slurp)'";

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
        "$mainMod SHIFT, E, exit"

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
        "$mainMod SHIFT, S, exec, ~/.config/hypr/scripts/playerctl-shuffle-toggle"
        "$mainMod SHIFT, L, exec, ~/.config/hypr/scripts/playerctl-loop-toggle"

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
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mainMod, code:1${toString i}, workspace, ${toString ws}"
              "$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
        9)
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

  # Session Environment Variables
  home.sessionVariables = {
    # Set to "1" if Cursor Keeps Disappearing
    WLR_NO_HARDWARE_CURSORS = "0";

		# Use Wayland
    GTK_USE_PORTAL = "1";
    XDG_SESSION_TYPE = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    GDK_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
  };
}
