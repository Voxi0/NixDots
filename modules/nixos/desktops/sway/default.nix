{ lib, config, username, pkgs, ... }: {
  # Module options
  options.enableSway = lib.mkOption {
    type = lib.types.bool;
    default = false;
    example = true;
    description = "Enable Sway";
  };

  # Configuration
  config = lib.mkIf config.enableSway {
    # Programs
    programs = {
      # Required for SwayWM to show up in display managers
      sway = {
        enable = true;
        package = null;
        extraPackages = with pkgs; [
          brightnessctl pamixer # To control brightness and volume
          wl-clipboard          # Clipboard
          dmenu-wayland         # App launcher
          feh grim slurp        # Image viewer and screenshotting tools
        ];
      };

      # Add SwayWM to UWSM
      uwsm = {
        enable = true;
        waylandCompositors.sway = {
          prettyName = "SwayWM";
          comment = "SwayWM managed by UWSM";
          binPath = "/etc/profiles/per-user/${username}/bin/sway";
        };
      };
    };

    # Home Manager
    home-manager.users.${username} = {
      # Secret service provider
      services.gnome-keyring.enable = true;

      # SwayWM
      wayland.windowManager.sway =  let
        modifier = "Mod4";
        terminal = "kitty";
        workspaces = [ 0 1 2 3 4 5 6 7 8 9 ];
      in {
        enable = true;
        systemd.enable = true;
        xwayland = true;
        wrapperFeatures.gtk = true;
        config = {
          inherit modifier terminal;
          startup = [];
          window = {
            titlebar = false;
            border = 1;
          };
          input = {
            "type:keyboard" = {
              xkb_layout = "gb";            # Keyboard layout
              xkb_options = "caps:escape";  # Map Caps Lock to work as the Escape key - Awesome for Neovim
              xkb_numlock = "enabled";      # Numlock enabled by default
              repeat_delay = "300";
              repeat_rate = "60";
            };
            "type:touchpad" = {
              tap = "enabled";              # Tap to click
              dwt = "enabled";              # Disable while typing
              natural_scroll = "disabled";  # Swipe in the direction to scroll
              scroll_method = "two_finger"; # Two fingers for scrolling
              accel_profile = "flat";       # Disable mouse acceleration
            };
          };
          keybindings = builtins.foldl'(acc: i:
            acc // {
              # Move to workspace
              "${modifier}+${toString i}" = "workspace number ${toString i}";
              "${modifier}+KP_${toString i}" = "workspace number ${toString i}";

              # Move active window to workspace
              "${modifier}+Shift+${toString i}" = "move container to workspace number ${toString i}";
              "${modifier}+Shift+KP_${toString i}" = "move container to workspace number ${toString i}";
            }
          ) {
              # Basics
              "${modifier}+Return" = "exec ${terminal}";
              "${modifier}+d" = "exec dmenu-wl_run -i";
              "${modifier}+f" = "fullscreen";
              "${modifier}+v" = "floating toggle";
              "${modifier}+q" = "kill";
              "${modifier}+Shift+c" = "reload";
              "${modifier}+Shift+e" = "exec swaynag -t warning -m 'Exit Sway?' -B 'Yes' 'swaymsg exit'";

              # Layouts
              "${modifier}+s" = "layout stacking";
              "${modifier}+w" = "layout tabbed";
              "${modifier}+e" = "layout toggle split";

              # Brightness control
              "XF86MonBrightnessUp" = "exec brightnessctl s +5%";
              "XF86MonBrightnessDown" = "exec brightnessctl s 5%-";
              "${modifier}+Control+Up" = "exec brightnessctl s +5%";
              "${modifier}+Control+Down" = "exec brightnessctl s 5%-";
              "${modifier}+Shift+Control+Up" = "exec brightnessctl s -d kbd_backlight 5%-";
              "${modifier}+Shift+Control+Down" = "exec brightnessctl s -d kbd_backlight +5%";

              # Media/Audio control
              "XF86AudioRaiseVolume" = "exec pamixer -i 5";
              "XF86AudioLowerVolume" = "exec pamixer -d 5";
              "XF86AudioMute" = "exec pamixer --toggle-mute";
              "${modifier}+Shift+Up" = "exec pamixer -i 5";
              "${modifier}+Shift+Down" = "exec pamixer -d 5";
              "${modifier}+Shift+m" = "exec pamixer --toggle-mute";

              # Screenshot
              "${modifier}+Shift+Insert" = "exec grim";
              "${modifier}+Alt+Insert" = ''exec grim -g "$(slurp)"'';
          } workspaces;
        };
      };
    };
  };
}
