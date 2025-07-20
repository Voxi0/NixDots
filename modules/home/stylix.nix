{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  # Import Nix modules
  imports = [inputs.stylix.homeManagerModules.stylix];

  # Module options
  options.enableStylix = lib.mkEnableOption "Enable Stylix for system-wide theming and typography";

  # Configuration
  config = lib.mkIf config.enableStylix {
    # Stylix
    stylix = {
      enable = true;
      autoEnable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

			# Icons
			iconTheme = {
      	enable = true;
      	package = pkgs.papirus-icon-theme;
      	light = "Papirus-Light";
      	dark = "Papirus-Dark";
    	};

      # Cursor
      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;
      };

      # Fonts
      fonts = {
        serif = config.stylix.fonts.sansSerif;
        sansSerif = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font Propo";
        };
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font Mono";
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
