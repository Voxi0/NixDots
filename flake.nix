{
  # Flake description
  description = "Voxi0's NixOS Flake";

  # Flake dependencies
  inputs = {
    # Nix package repository to use
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Manages user dotfiles
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # System-wide colorscheming and typography
    stylix.url = "github:danth/stylix";

		# Hyprland
		hyprland.url = "github:hyprwm/Hyprland";
		hyprland-plugins = {
			url = "github:hyprwm/hyprland-plugins";
			inputs.hyprland.follows = "hyprland";
		};

    # Efficient animated wallpaper daemon for wayland, controlled at runtime
    swww.url = "github:LGFae/swww";

    # AGS - Widget library
    ags.url = "github:aylur/ags/v2";

    # NVF
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Flake outputs/actions - What to do after fetching all dependencies
  outputs = { self, nixpkgs, ... }@inputs: let
    system = "x86_64-linux";
    username = "voxi0";
    genHostConfig = { hostname }: import ./hosts/host-config.nix {
      inherit nixpkgs system hostname username inputs;
    };
  in {
    # NixOS configurations
    nixosConfigurations = {
      neo = genHostConfig { hostname = "neo"; };
    };
  };
}
