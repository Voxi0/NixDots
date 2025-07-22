{ lib, config, ... }: {
	# Module options
	options.cli.enableFastfetch = "Enable Fastfetch - Feature-rich and performant system info tool";

	# Configuration
	config = lib.mkIf config.cli.enableFastfetch {
		home.shellAliases."ff" = "fastfetch";
		programs.fastfetch = {
			enable = true;
			settings = {
				logo.padding.right = 2;

				display = {
					color = "red";
					separator = "";
				};

				modules = [
					# Username and hostname
					{
						type = "title";
						# To display host name next to username - {at-symbol-colored}{host-name-colored}
						key = " ";
						format = "{user-name}";
					}

					# Distro name, kernel
					{
						type = "os";
						key = " ";
						format = "{3}";
					}
					{
						type = "kernel";
						key = " ";
						format = "{1} {2}";
					}

					# Shell, Window Manager (WM) / Desktop Environment (DE) and terminal
					{
						type = "shell";
						key = " ";
						format = "{6}";
					}
					{
						key = " ";
						type = "wm";
					}
					{
						key = "󱂬 ";
						type = "de";
					}
					{
						type = "terminal";
						key = " ";
						format = "{5}";
					}
				];
			};
		};
	};
}
