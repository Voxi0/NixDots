{ config, pkgs, ... }: {
  # Fish Shell Configuration
  programs.fish = {
	# Let Home Manager Install Fish Shell and Manage it
	enable = true;

	# Fish Shell Init Config
	interactiveShellInit = ''
	  # Disables Fish Shell Welcome Message
	  set fish_greeting
	'';

	# Fish Shell Plugins
	plugins = [
      # Prompt Plugin
	  {name = "tide"; src = pkgs.fishPlugins.tide.src;}
	];
  };
}
