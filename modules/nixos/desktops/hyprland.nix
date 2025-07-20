{
  system,
  inputs,
  pkgs,
  ...
}: let
  hyprlandPkgs = inputs.hyprland.packages.${system};
  hyprlandPluginsPkgs = inputs.hyprland-plugins.packages.${system};
in {
	# Module options
	options.desktop.hyprland.enable = lib.mkEnableOption "Enable Hyprland Wayland compositor";

	# Configuration
	config = lib.mkIf config.desktop.hyprland.enable {
		# Hyprland NixOS module - Required as it enables critical components needed to run Hyprland properly
		programs.hyprland = {
			enable = true;
			withUWSM = true;
			package = hyprlandPkgs.hyprland;
			portalPackage = hyprlandPkgs.xdg-desktop-portal-hyprland;
		};

		# Udisks2 - D-Bus service to access and manipulate storage devices
		services.udisks2.enable = true;
	};
}
