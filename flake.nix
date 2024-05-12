{
  # Flake Description
  description = "NixOS Flake";

  # Flake Dependencies
  inputs = {
    # Nix Packages Repo
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixVim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Flake Outputs - What to do After Fetching All The Flake Inputs
  outputs = { nixpkgs, home-manager, ... }@inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      NixOS = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager {
            # Use Packages Installed on System and User Profiles
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # Optionally Pass Through Arguments to 'home.nix' File Using 'extraSpecialArgs'

            # Users
            home-manager.users.voxi0 = {
              imports = [
                ./home/voxi0/home.nix
                inputs.nixvim.homeManagerModules.nixvim
              ];
            };
          }
        ];
      };
    };
  };
}
