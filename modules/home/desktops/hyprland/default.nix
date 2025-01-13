{ inputs, pkgs, ... }: let
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
  # Import Nix modules
  imports = [ ./apps ];

  # Home
  home = {
    # Base/Required packages
    packages = with pkgs; [
      # Base
      hyprpolkitagent libnotify inputs.swww.packages.${pkgs.system}.swww
      libsForQt5.qt5.qtwayland kdePackages.qtwayland qt6Packages.qt6ct

      # Utilities
      pamixer brightnessctl playerctl grim slurp feh udiskie hyprshade
    ];

    # Hyprcursor
    pointerCursor.hyprcursor.enable = true;
  };

  # Playerctl - Mpris media player CLI controller for VLC, Spotify, CMus etc
  services.playerctld.enable = true;

  # Stop Stylix from using Hyprpaper to set the wallpaper - We want to use SWWW for wallpapers instead
  stylix.targets = {
    hyprland.enable = false;  # Must be disabled in order to disable Hyprpaper without any conflicts
    hyprpaper.enable = false;
    hyprlock.enable = false;  # So we can set a custom background for Hyprlock
  };

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
		xwayland.enable = true;
    systemd = {
      enable = false;
      variables = ["--all"];
    };

    # Plugins and settings
    plugins = with inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}; [];
    settings = {
      ################
      ### MONITORS ###
      ################
      "monitor" = ",preferred,auto,auto";

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

      # Command to lock the screen or bring up the logout menu
      "$lockscreenCmd" = "uwsm app -- hyprlock";
      "$logoutMenuCmd" = "uwsm app -- wlogout";

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
      "$selectedAreaScreenshotCmd" = ''grim -g "$(slurp)"'';

      #################
      ### AUTOSTART ###
      #################
      exec-once = [
        "systemctl --user enable --now hyprpolkitagent.service"
        "uwsm app -- swww-daemon"
        "swww restore"
        "uwsm app -- ags run --gtk4"
        "uwsm app -- udiskie --automount --smart-tray --terminal=$terminal"
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
        # Master switch for pseudotiling. Enabling is bound to mainMod + P
        pseudotile = true;
        preserve_split = true;                 # You probably want this
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
        rounding = 6;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        # Drop shadow
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
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
        "$mainMod, L, exec, $lockscreenCmd"
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
      ] ++ (
        # Workspaces
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mainMod, code:1${toString i}, workspace, ${toString ws}"
              "$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
        10)
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

  # Hyprlock
  home.file.".config/hypr/background.png".source = ../../Pictures/Wallpapers/night_city.png;
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [{
        path = "~/.config/hypr/background.png";
        blur_passes = 1;
        blur_size = 4;
      }];

      # General
      general = {
        hide_cursor = true;
        no_fade_in = true;
        no_fade_out = true;
        disable_loading_bar = true;
        ignore_empty_input = true;
        immediate_render = false;
        grace = 0;
        text_trim = true;
        fractional_scaling = 2;
      };
      
      # Authentication - Configure fingerprint
      auth.fingerprint = {
        enabled = true;
        ready_message = "Scan Fingerprint to Unlock";
        present_message = "Scanning Fingerprint";
      };

      # Password input field
      input-field = [{
        # Z-Index - Can be used to position the input field on top of or on the bottom of another widget
        zindex = 0;

        # Box style
        size = "200,50";
        outline_thickness = 0;
        rounding = 6;
        position = "0, -100";
        halign = "center";
        valign = "center";

        # Colors
        font_color = "rgb(255, 255, 255)";
        inner_color = "rgb(0, 0, 0)";
        outer_color = "rgb(0, 0, 0)";
        fail_color = "rgba(150, 0, 0, 1.0)";
        capslock_color = "rgba(0, 150, 0, 1.0)";

        # When input field is empty
        fade_on_empty = false;
        placeholder_text = ''<i>Password</i>'';

        # Password is displayed as dots
        hide_input = false;
        dots_size = "0.15";
        dots_center = true;
        dots_rounding = "-1";

        # Wrong password
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        fail_timeout = "3000";
      }];

      # Widgets
      label = [
        {
          monitor = "DP-2";
          text = "$TIME";
          color = "rgb(255, 255, 255)";
          font_size = 95;
          font_family = "JetBrains Mono";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {

          monitor = "DP-2";
          text = ''cmd[update:1000] echo $(date +"%A, %B %d")'';
          color = "rgb(255, 255, 255)";
          font_size = 22;
          font_family = "JetBrains Mono";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  # Wlogout - Wayland logout menu
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Restart";
        keybind = "r";
      }
      {
        label = "lockscreen";
        action = "hyprlock";
        text = "Lock Screen";
        keybind = "l";
      }
    ];
    style = ''
      button {
        background-color: #000000;
        color: #ffffff;
        border: none;
        border-radius: 6px;
        margin: 0px 6px;
        transition-duration: 0.2s;
      }
      button:hover {background-color: #091059;}
    '';
  };
}
