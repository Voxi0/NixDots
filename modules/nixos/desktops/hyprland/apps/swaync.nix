{ lib, config, pkgs, ... }: {
	# Module options
	options.enableSwayNC = lib.mkEnableOption "Enable Sway Notification Center";

	# Configuration
	config = lib.mkIf config.enableSwayNC {
		services.swaync = {
			enable = true;
			settings = {
				layer = "overlay";
				layer-shell = true;
				positionY = "top";
				positionX = "right";

				control-center-layer = "top";
				control-center-margin-top = 0;
				control-center-margin-bottom = 0;
				control-center-margin-right = 0;
				control-center-margin-left = 0;

				notification-icon-size = 64;
				notification-body-image-height = 100;
				notification-body-image-width = 200;
			};
			style = ''
				.notification {
					border-radius: 12px;
					margin: 6px 12px;
					box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.3), 0 1px 3px 1px rgba(0, 0, 0, 0.7),
						0 2px 6px 2px rgba(0, 0, 0, 0.3);
					padding: 0;
				}
			'';
		};
	};
}
