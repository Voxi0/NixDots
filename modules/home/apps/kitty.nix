{ pkgs, lib, config, ... }: {
  # Module options
  options = {
    kitty.enable = lib.mkEnableOption "Enables Kitty";
  };

  # Configure Kitty if it's enabled
  config = lib.mkIf config.kitty.enable {
    # Install CLI utilities
    home.packages = with pkgs; [
      neovim lf btop
    ];

    # Kitty terminal configuration
    programs.kitty = {
      enable = true;
      settings = {
        # Disable popup confirmation window when closing Kitty terminal
        confirm_os_window_close = 0;

        # Font
        font_size = "11.0";

        # Cursor
        cursor_shape = "beam";
        cursor_beam_thickness = "1.0";
        cursor_blink_interval = 0;

        # Performance tuning
        sync_to_monitor = true;

        # Terminal bell
        enable_audio_bell = true;
        window_alert_on_bell = true;
      };
    };

    # Fastfetch - Fetch script configuration
    programs.fastfetch = {
      enable = true;
      package = pkgs.fastfetch;
      settings = {
        logo = {
          source = "nixos_small";
          padding = {
            right = 1;
          };
        };
        display = {
          size = {
            binaryPrefix = "si";
          };
          color = "blue";
          separator = "  ";
        };
        modules = [
          {
            type = "datetime";
            key = "Date";
            format = "{1}-{3}-{11}";
          }
          {
            type = "datetime";
            key = "Time";
            format = "{14}:{17}:{20}";
          }
          "break"
          "player"
          "media"
        ];
      };
    };
  };
}
