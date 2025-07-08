# Xserver/Xorg/X11 display server configuration - Please use Wayland if possible
{ lib, config, pkgs, kbLayout, ... }: {
	# Module options
	options.enableX11 = lib.mkEnableOption "Enable X11 display server";

	# Configuration
	config.services.xserver = lib.mkIf config.enableX11 {
		enable = true;
		excludePackages = [ pkgs.xterm ];
		videoDrivers = lib.mkIf config.enableNvidia [ "nvidia" ];
		xkb = {
			layout = kbLayout;
			variant = "";
		};
	};
}
