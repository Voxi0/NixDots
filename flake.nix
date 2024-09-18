{
  description = "Voxi0's NixOS Flake";

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
  };

  outputs = { self, nixpkgs, ... }@inputs: let
    system = "x86_64-linux";
    username = "voxi0";
    pkgs = nixpkgs.legacyPackages.${system};
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
