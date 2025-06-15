{
  description = "NixDots";

  # Dependencies
  inputs = {
    # Nix packages repository
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		# Declarative Flatpak manager for NixOS
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

		# My personal Hyprland configuration
		NixDotsHyprland = {
			url = "github:Voxi0/NixDots-Hyprland";
			inputs.nixpkgs.follows = "nixpkgs";
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

		# Multiplatform CLI tool to customize the official Spotify client
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Actions to perform after fetching all dependencies
  outputs = { nixpkgs, ... }@inputs: let
		systemDisk = "/dev/sda";
    system = "x86_64-linux";
		hostname = "neo";
		username = "voxi0";
		locale = "en_GB.UTF-8";
    timezone = "Europe/London";
    kbLayout = "gb";
		genHostConfig = { hostname }: import ./hosts/host-config.nix {
			inherit nixpkgs systemDisk system inputs hostname username locale timezone kbLayout;
		};
  in {
    nixosConfigurations = {
      neo = genHostConfig { hostname = "neo"; };
    };
  };
}
