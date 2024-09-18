{ pkgs, lib, config, ... }: {
  # Module options
  options = {
    kitty.enable = lib.mkEnableOption "Enables Kitty";
  };

  # Configure Kitty if it's enabled
  config = lib.mkIf config.kitty.enable {
    # Install CLI utilities
    home.packages = with pkgs; [
      neovim lf neofetch btop
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
  };
}
