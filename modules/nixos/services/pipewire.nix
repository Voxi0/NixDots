# Pipewire for audio
{ lib, config, pkgs, ... }: {
	# Module options
	options.enableAudio = lib.mkEnableOption "Enable Pipewire for audio";

	# Configuration
	config = lib.mkIf config.enableAudio {
		environment.systemPackages = [ pkgs.pavucontrol ];
		services = {
			pulseaudio.enable = false;
			pipewire = {
				enable = true;
				wireplumber.enable = true;
				alsa.enable = true;
				alsa.support32Bit = true;
				pulse.enable = true;
				jack.enable = true;
			};
		};
	};
}
