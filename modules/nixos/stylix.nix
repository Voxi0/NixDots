{ pkgs, ... }: {
  # Stylix - Manges theme and fonts
  stylix = {
    # Enable/Disable Stylix
    enable = true;

    # Enable/Disable setting Stylix themes for various apps automatically
    autoEnable = true;

    # Wallpaper - Used to generate a colorscheme if one isn't set manually. Also sets the desktop wallpaper if possible
    image = ./../home/Pictures/Wallpapers/wallpaper3.jpg;
    imageScalingMode = "fill";

    # Force light/dark when generating a theme using the wallpaper
    polarity = "dark";

    # Base16 theme
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    # Cursor
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    # Fonts
    fonts = {
      # Font
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      # Font sizes
      sizes = {
        desktop = 10;
        applications = 11;
        terminal = 11;
        popups = 10;
      };
    };
    
    # Opacity/Transparency of various applications
    opacity = {
      desktop = 1.0;
      applications = 1.0;
      terminal = 0.8;
      popups = 1.0;
    };
  };
}
