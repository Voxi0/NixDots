{ inputs, system, ... }: {
	home.packages = [ inputs.quickshell.packages.${system}.default ];
}
