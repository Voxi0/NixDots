{ config, ... }: {
  # Kitty Terminal Configuration
  programs.kitty = {
	# Let Home Manager Install and Manage Kitty Terminal
	enable = true;

	# Theme
	theme = "Catppuccin-Mocha";

	# Settings
	settings = {
      # Disable Popup Confirmation Window When Closing Kitty Terminal
      confirm_os_window_close = 0;

      # Font
      font_family = "JetBrainsMono Nerd Font";
      font_size = "11.0";

      # Background Opacity/Transparency
      background_opacity = "0.5";

	  # Cursor
      cursor_shape = "beam";
      cursor_beam_thickness = "1.0";
      cursor_blink_interval = 0;

      # Performance Tuning
      sync_to_monitor = true;

      # Terminal Bell
      enable_audio_bell = true;
      window_alert_on_bell = true;
	};
  };
}
