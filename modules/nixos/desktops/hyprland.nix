{ inputs, ... }: {
	# Hyprland NixOS module - Required as it enables critical components needed to run Hyprland properly
	programs.hyprland = {
		enable = true;
		withUWSM = true;
		package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
		portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
	};
}
