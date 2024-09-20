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
          source = ./../Pictures/Fastfetch/howls.png;
          width = 25;
        };
        modules = [
          # Start
          {
            type = "custom";
            format = "\u001b[36m    コンピューター";}
          {
            type = "custom";
            format = "┌────────────────────────────────────────────────────┐";}

          # OS, Kernel, Packages and Display
          {
            type = "os";
            key = "   OS";
            keyColor = "red";}
          {
              type = "kernel";
              key = "   Kernel";
              keyColor = "red";}
          {
            type = "packages";
            key = "   Packages";
            keyColor = "green";}
          {
            type = "display";
            key = "  󰍹 Display";
            keyColor = "green";}

          # User, WM, Terminal and Uptime
          {
            type = "title";
            key = "  ";}
          {
            type = "wm";
            key = "  󱂬 WM";
            keyColor = "yellow";}
          {
            type = "terminal";
            key = "   Terminal";
            keyColor = "yellow";}
          {
            type = "uptime";
            key = "  󱫐 Uptime ";
            keyColor = "red";}
          {
            type = "custom";
            format = "└───────────────────────────────────────────────────┘";}
          
          {
            type = "colors";
            paddingLeft = 2;
            symbol = "circle";}
        ];
      };
    };
  };
}
