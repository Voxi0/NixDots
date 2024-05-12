{ config, pkgs, ... }: {
  # Mako Configuration
  services.mako = {
    # Enable/Disable Mako
    enable = true;

    # Notification Settings
    maxVisible = 3;
    layer = "overlay";
    anchor = "top-right";
    sort = "-time";

    # Font and Background/Text Color
    font = "JetBrainsMono Nerd Font 11";
    backgroundColor = "#1e1e2e";
    textColor = "#cdd6f4";

    # Icons
    icons = true;
    maxIconSize = 64;

    # Border
    borderSize = 1;
    borderColor = "#f2cdcd";
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
}
