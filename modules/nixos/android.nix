{ lib, config, username, pkgs, ... }: {
	# Module options
	options.enableAndroid = "Install Android Development Tools";

	# Configuration
	config = {
		# Android Debug Bridge (ADB) - For debugging
		users.users.${username}.extraGroups = [ "adbusers" ];
		programs.adb.enable = true;

		# Android development - Android studio
		home-manager.users.${username}.home.packages = with pkgs; [ android-studio ];
	};
}
