_: {
	wayland.windowManager.hyprland.settings = {
		##############################
		### WINDOWS AND WORKSPACES ###
		##############################
		windowrulev2 = [
			# Ignore maximize requests from apps - You'll probably like this
			"suppressevent maximize, class:.*"

			# Fix some dragging issues with XWayland
			"nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
		];

		# Window layouts
		master.new_status = "master";
		dwindle = {
			# Master switch for pseudotiling - Enable with `mainMod + P`
			pseudotile = true;
			preserve_split = true;
		};

		# Window decorations
		decoration = {
			# Radius of rounded window corners
			rounding = 6;

			# Transparency of focused and unfocused windows
			active_opacity = 1.0;
			inactive_opacity = 1.0;

			# Drop shadow
			shadow = {
				enabled = true;
				range = 4;
				render_power = 3;
				color = "rgba(1a1a1aee)";
			};

			# Blur
			blur = {
				enabled = true;
				size = 3;
				passes = 1;
				vibrancy = 0.1696;
			};
		};
	};
}
