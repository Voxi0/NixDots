{ lib, config, username, inputs, pkgs, ... }: {
  # Module options
  options.enableHyprland = lib.mkOption {
    type = lib.types.bool;
    default = false;
    example = true;
    description = "Enable Hyprland";
  };

  # Configuration
  config = lib.mkIf config.enableHyprland {
    # Nix
    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };

    # Hyprland NixOS module - Required as it enables critical components needed to run Hyprland properly
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    # Home Manager
    home-manager.users.${username} = {
      # Import Nix modules - Only for Home Manager
      imports = [ ./apps ];

      # Enable/Disable Home Manager modules
      enableWofi = true;
      enableMako = true;
      enableAGS = true;
      enableWlogout = true;

      # Home
      home = {
        # Base/Required packages
        packages = with pkgs; [
          # Base
          hyprpolkitagent libnotify swww

          # Utilities
          wl-clipboard unzip grim slurp feh udiskie hyprshade
        ];

        # Hyprcursor
        pointerCursor.hyprcursor.enable = true;
      };

      # Services
      services = {
        # Mpris media player CLI controller for VLC, Spotify, CMus etc
        playerctld.enable = true;

        # On Screen Display (OSD)
        swayosd = {
          enable = true;
          topMargin = 0.1;
        };
      };

      # Stop Stylix from using Hyprpaper to set the wallpaper - We want to use SWWW for wallpapers instead
      stylix.targets = {
        hyprland.enable = false;  # Must be disabled in order to disable Hyprpaper without any conflicts
        hyprpaper.enable = false;
      };

      # Hyprland
      wayland.windowManager.hyprland = let
        # To easily access custom options like `enableAGS` for extra configuration
        options = config.home-manager.users.${username};

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

          # Command to bring up the logout menu
          "$logoutMenuCmd" = (lib.mkIf (options.enableWlogout) ("uwsm app -- wlogout"));

          # Commands to control volume
          "$increaseVolumeCmd" = "swayosd-client --output-volume +5 --max-volume 100";
          "$decreaseVolumeCmd" = "swayosd-client --output-volume -5 --max-volume 100";
          "$toggleAudioMuteCmd" = "swayosd-client --output-volume mute-toggle";

          # Commands to control screen brightness
          "$increaseBrightnessCmd" = "swayosd-client --brightness +5";
          "$decreaseBrightnessCmd" = "swayosd-client --brightness -5";

          # Commands to use for screenshots - For the entire screen or selected area
          "$fullscreenScreenshotCmd" = "grim - | wl-copy";
          "$selectedAreaScreenshotCmd" = ''grim -g "$(slurp)" - | wl-copy'';

          #################
          ### AUTOSTART ###
          #################
          exec-once = [
            "systemctl --user enable --now hyprpolkitagent.service"
            "uwsm app -- swww-daemon"
            "swww restore"
            (lib.mkIf options.enableAGS "uwsm app -- ags run --gtk4")
            "uwsm app -- udiskie --automount --smart-tray --terminal=$terminal"
            "hyprshade on vibrance"
            (lib.mkIf (pkgs.mpdscribble != null) "uwsm app -- mpdscribble")
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
            (lib.mkIf (options.enableWlogout) "$mainMod SHIFT, E, exec, $logoutMenuCmd")

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
    };
  };
}
