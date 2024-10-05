{ lib, config, inputs, pkgs, ... }: {
  # Module options
  options = {
    ags.enable = lib.mkEnableOption "Enables AGS";
  };

  # Configure AGS if it's enabled
  config = lib.mkIf config.ags.enable {
    # Import Nix modules
    imports = [
      inputs.ags.homeManagerModules.default
    ];

    # AGS configuration
    programs.ags = {
      enable = true;
      configDir = ./dotfiles; # Leave as "null" if you don't want Home Manager to manage AGS dotfiles

      # Additional packages to add to GJS's runtime
      extraPackages = with pkgs; [
        gtksourceview webkitgtk accountsservice
      ];
    };
  };
}
