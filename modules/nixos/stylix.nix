{ lib, config, inputs, pkgs, ... }: {
  # Import Nix modules
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  # Module options
  options = {
    enableStylix = lib.mkEnableOption "Enables Stylix";
  };

  # Stylix - Manges theme and fonts
  config = lib.mkIf config.enableStylix {
    stylix = {
      # Enable/Disable Stylix
      enable = true;

      # Enable/Disable setting Stylix themes for various apps automatically
      autoEnable = true;
    
      # Image used to generate a colorscheme if one isn't set manually - Also sets the image as wallpaper if possible
      image = ./../home/Pictures/Wallpapers/lain.jpg;

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
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
        };
        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
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
        terminal = 1.0;
        popups = 1.0;
      };
    };
  };
}
