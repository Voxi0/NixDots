{ lib, config, inputs, pkgs, ... }: {
  # Import Nix modules
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  # Module options
  options = {
    enableAGS = lib.mkEnableOption "Enables AGS";
  };

  # Configure AGS if it's enabled
  config = lib.mkIf config.enableAGS {
    # AGS configuration
    programs.ags = {
      enable = true;
      configDir = ./dotfiles; # Leave as "null" if you don't want Home Manager to manage AGS dotfiles

      # Additional packages to add to GJS's runtime
      extraPackages = with pkgs; [
        gtksourceview webkitgtk accountsservice
      ] ++ (with inputs.ags.packages.${pkgs.system}; [
        hyprland battery
      ]);
    };
  };
}
