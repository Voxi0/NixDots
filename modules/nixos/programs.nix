{ inputs, pkgs, ... }: {
  # Programs
  programs = {
    # Some programs need SUID wrappers - Can be configured further or are started in user sessions
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    zsh.enable = true;      # Required to set ZSH as the default shell for the user

		# Universal wayland session manager
		uwsm = {
			enable = true;
			waylandCompositors = {
				hyprland = {
					prettyName = "Hyprland";
					comment = "Hyprland managed by UWSM.";
					binPath = "/run/current-system/sw/bin/Hyprland";
				};
			};
		};

		# Hyprland NixOS module - Required as it enables critical components needed to run Hyprland properly
		hyprland = {
			enable = true;

			# Set the flake package and sync the portal package
			package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
			portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
		};
  };
}
