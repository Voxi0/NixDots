{ lib, config, pkgs, ... }: {
  # Module options
  options = {
    wofi.enable = lib.mkEnableOption "Enables Wofi";
  };

  # Configure Wofi if it's enabled
  config = lib.mkIf config.wofi.enable {
    # Don't let Stylix style Wofi
    stylix.targets.wofi.enable = false;

    # Wofi configuration
    programs.wofi = {
      enable = true;
      package = pkgs.wofi;
      settings = {
        mode = "drun";
        allow_images = true;
        image_size = 32;
        width = 440;
        height = 240;
      };
      style = ''${builtins.readFile(./style.css)}'';
    };
  };
}
