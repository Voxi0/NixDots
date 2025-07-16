{ pkgs, ... }: {
	home.packages = with pkgs; [ quickshell ];
	programs.quickshell = {
		enable = true;
		systemd.enable = true;
		activeConfig = "default";
		configs = {
			default = ../quickshell;
		};
	};
}
