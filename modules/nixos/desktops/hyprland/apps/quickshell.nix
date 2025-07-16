{ pkgs, ... }: {
	home.packages = with pkgs; [ quickshell ];
	programs.quickshell = {
		enable = true;
		systemd.enable = true;
		systemd.target = "uwsm-session.target";
		activeConfig = "default";
		configs = {
			default = ../quickshell;
		};
	};
}
