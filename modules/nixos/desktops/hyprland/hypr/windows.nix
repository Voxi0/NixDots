_: {
	##############################
	### WINDOWS AND WORKSPACES ###
	##############################
	wayland.windowManager.hyprland.settings = {
		windowrulev2 = [
			# Ignore maximize requests from apps - You'll probably like this
			"suppressevent maximize, class:.*"

			# Fix some dragging issues with Xwayland
			"nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
		];

		# Window layouts
		general.layout = "dwindle";		# Default window layout
		master.new_status = "master";
		dwindle = {
			# Enable/Disable pseudotiling - Toggle `mainMod + P`
			pseudotile = true;
			preserve_split = true;
		};
	};
}
