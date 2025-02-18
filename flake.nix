{
  # Flake description
  description = "NixDots";

  # Flake inputs/dependencies
  inputs = {
    # Nix packages repository
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Manages user dotfiles
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Declaratively partition and format disks using Nix
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # System-wide theming and typography
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
		ags.url = "github:aylur/ags";

    # Firefox extensions
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # My Neovim configuration
    NixNvim = {
      url = "github:Voxi0/NixNvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Manage Vencord settings and plugins declaratively with Nix
    nixcord.url = "github:kaylorben/nixcord";

    #Multiplatform CLI tool to customize the official Spotify client
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Flake actions - What to do with the flake inputs/dependencies
  outputs = { nixpkgs, ... }@inputs: let
    systemDisk = "/dev/sda";
    system = "x86_64-linux";
    username = "voxi0";
    genHostConfig = { hostname }: import ./hosts/host-config.nix {
      inherit nixpkgs system inputs hostname username;
    };
  in {
    # NixOS configurations
    nixosConfigurations = {
      neo = genHostConfig { hostname = "neo"; };
    };
  };
}
