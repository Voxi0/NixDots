{
  # Flake description
  description = "NixDots";

  # Flake dependencies
  inputs = {
    # Nix package repository to use
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		# Disko
		disko = {
			url = "github:nix-community/disko";
			inputs.nixpkgs.follows = "nixpkgs";
		};

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
			inputs.hyprland.follows = "hyprland";   # Sync with latest Hyprland version
		};

    # Efficient animated wallpaper daemon for wayland, controlled at runtime
    swww.url = "github:LGFae/swww";

    # AGS - Widget library
		ags.url = "github:aylur/ags";

    # NVF - Neovim distro
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		# Declarative Vencord plugins + options
		nixcord.url = "github:kaylorben/nixcord";
  };

  # Flake outputs/actions - What to do after fetching all dependencies
  outputs = { nixpkgs, ... }@inputs: let
    system = "x86_64-linux";
		systemDisk = "/dev/sda";
    username = "voxi0";
    genNixOSHostConfig = { hostname }: import ./hosts/nixos-host-config.nix {
      inherit nixpkgs system systemDisk hostname username inputs;
    };
    genHomeHostConfig = { hostname }: import ./hosts/home-host-config.nix {
      inherit nixpkgs hostname username system inputs;
    };
  in {
    # NixOS configurations
    nixosConfigurations = {
      neo = genNixOSHostConfig { hostname = "neo"; };
    };

    # Home manager configurations
    homeConfigurations = {
      neo = genHomeHostConfig { hostname = "neo"; };
    };
  };
}
