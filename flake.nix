{
  description = "NixDots";

  # Dependencies
  inputs = {
    # Nix packages repository and declarative Flatpak manager
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

		# Manages user-level configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		# System-wide theming and typography
		stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		# Hyprland
		hyprland.url = "github:hyprwm/Hyprland";
		hyprland-plugins = {
			url = "github:hyprwm/hyprland-plugins";
			inputs.hyprland.follows = "hyprland";
		};

		# Firefox extensions
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # My personal Neovim configuration using nixCats
    NixNvim = {
      url = "github:Voxi0/NixNvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		# Declaratively configure Vencord and it's plugins
		nixcord.url = "github:kaylorben/nixcord";

		# Multiplatform CLI tool to customize the official Spotify client
		spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  # Actions to perform after fetching all dependencies
  outputs = { nixpkgs, ... }@inputs: let
    system = "x86_64-linux";
		hostname = "desktop";
		username = "voxi0";
		locale = "en_GB.UTF-8";
    kbLayout = "gb";
		genHostConfig = { hostname }: import ./hosts/host-config.nix {
			inherit nixpkgs system inputs hostname username locale kbLayout;
		};
  in {
    nixosConfigurations = {
			laptop = genHostConfig { hostname = "laptop"; };
      desktop = genHostConfig { hostname = "desktop"; };
    };
		homeConfigurations.${username} = inputs.home-manager.lib.homeManagerConfiguration {
			inherit system username;
			homeDirectory = "/home/${username}";
			backupFileExtension = "bak";
			configuration = ./hosts/${hostname}/home.nix;
			extraSpecialArgs = { inherit system inputs username; };
		};
  };
}
