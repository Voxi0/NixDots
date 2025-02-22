{ lib, config, inputs, pkgs, ... }: {
  # Import Nix modules
  imports = [ inputs.ags.homeManagerModules.default ];

  # Module options
  options.enableAGS = lib.mkEnableOption "AGS (Widgets)";

  # Configuration
  config = lib.mkIf config.enableAGS {
    # Extra packages (REQUIRED)
		home.packages = with pkgs; [ sassc ];

    # AGS configuration
    programs.ags = {
      enable = true;
      configDir = null;

      # Additional packages to add to GJS's runtime
      extraPackages = with pkgs; [
        gtksourceview webkitgtk accountsservice
      ] ++ (with inputs.ags.packages.${pkgs.system}; [
        hyprland powerprofiles battery network wireplumber mpris notifd bluetooth tray
      ]);
    };
  };
}
