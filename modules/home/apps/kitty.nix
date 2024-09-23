{ pkgs, lib, config, ... }: {
  # Module options
  options = {
    kitty.enable = lib.mkEnableOption "Enables Kitty";
  };

  # Configure Kitty if it's enabled
  config = lib.mkIf config.kitty.enable {
    # Install CLI utilities
    home.packages = with pkgs; [
      lf btop
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

    # Fetch script configurations
    # Fastfetch
    programs.fastfetch = {
      enable = true;
      package = pkgs.fastfetch;
      settings = {
        logo = {
          type = "kitty";
          source = ./../Pictures/Fastfetch/pochita.png;
          width = 25;
          height = 12;
        };

        display.separator = " > ";

        modules = [
          # OS, Kernel, Packages and Display
          {
            type = "os";
            paddingLeft = 4;
            key = "\t OS";
            keyColor = "red";
            format = "{name} {version}";}
          {
            type = "kernel";
            paddingLeft = 4;
            key = "\t Kernel";
            keyColor = "red";}
          {
            type = "packages";
            paddingLeft = 4;
            key = "\t Packages";
            keyColor = "green";}
          {
            type = "display";
            paddingLeft = 4;
            key = "\t󰍹 Display";
            keyColor = "green";
            format = "{width}x{height}";}

          # User, WM, Terminal and Uptime
          {
            type = "title";
            paddingLeft = 4;
            key = "\t";}
          {
            type = "wm";
            paddingLeft = 4;
            key = "\t󱂬 WM";
            keyColor = "yellow";}
          {
            type = "terminal";
            paddingLeft = 4;
            key = "\t Terminal";
            keyColor = "yellow";}
          {
            type = "uptime";
            paddingLeft = 4;
            key = "\t󱫐 Uptime";
            keyColor = "red";}
        ];
      };
    };
  };
}
