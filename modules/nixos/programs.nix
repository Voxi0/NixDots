{ inputs, pkgs, ... }: {
  # Programs
  programs = {
    # Some programs need SUID wrappers - Can be configured further or are started in user sessions
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # UWSM - Universal Wayland Session Manager
    uwsm = {
      enable = true;
      package = pkgs.uwsm;
      waylandCompositors = {
        hyprland = {
          prettyName = "Hyprland";
          comment = "Hyprland compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/Hyprland";
        };
      };
    };

		# Hyprland NixOS module - Required as it enables critical components needed to run Hyprland properly
		hyprland = {
			enable = true;
      withUWSM = true;

			# Set the flake package and sync the portal package
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
		};
  };
}
