{ lib, config, ... }: {
  # Module options
  options.enableMako = lib.mkEnableOption "Mako (Notification daemon)";

  # Configuration
  config = lib.mkIf config.enableMako {
    # Mako
    services.mako = {
      # Enable/Disable Mako
      enable = true;

      # Notification settings
      maxVisible = 3;
      layer = "overlay";
      anchor = "top-right";
      sort = "-time";

      # Icons
      icons = true;
      maxIconSize = 64;

      # Border
      borderSize = 1;
      borderRadius = 6;

      # Extra Config
      extraConfig = ''
        # Icon Location
        icon-location=left

        # Mouse Button Actions
        on-button-left=invoke-default-action
        on-button-middle=dismiss-all
        on-button-right=dismiss
      '';
    };
  };
}
