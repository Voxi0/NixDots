{
  # Description
  description = "NixDots";

  # Dependencies
  inputs = {
    # Nix packages repository
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Secure boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

		# My Hyprland configuration
		NixDotsHyprland = {
			url = "github:Voxi0/NixDots-Hyprland";
			inputs.nixpkgs.follows = "nixpkgs";
		};

    # Firefox extensions
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Declarative Flatpak manager for NixOS
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    # My Neovim configuration
    NixNvim = {
      url = "github:Voxi0/NixNvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Manage Vencord settings and plugins declaratively with Nix
    nixcord.url = "github:kaylorben/nixcord";

    # Multiplatform CLI tool to customize the official Spotify client
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Actions - Executed after fetching all dependencies
  outputs = { nixpkgs, ... }@inputs: let
    systemDisk = "/dev/sda";
    system = "x86_64-linux";
    username = "voxi0";
    locale = "en_GB.UTF-8";
    timezone = "Europe/London";
    keymap = "uk";
    xkbLayout = "gb";

    genHostConfig = { hostname }: import ./hosts/host-config.nix {
      inherit nixpkgs system inputs hostname username locale timezone keymap xkbLayout;
    };
  in {
    # NixOS configurations
    nixosConfigurations = {
      neo = genHostConfig { hostname = "neo"; };
    };
  };
}
