# Function to easily create new NixOS configurations in the system flake
{ nixpkgs, system, inputs, hostname, username, ... }: nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs hostname username; };
  modules = [
    inputs.disko.nixosModules.default
    ./${hostname}/configuration.nix {
      # Nix packages
      nixpkgs.config.allowUnfree = true;

      # Nix
      nix = {
        optimise.automatic = true;
        settings = {
          experimental-features = [ "nix-command" "flakes" ];
          auto-optimise-store = true;
        };
      };
    }
    inputs.home-manager.nixosModules.home-manager {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit system inputs username; };
        backupFileExtension = "bak";

        # User
        users.${username} = {
          # Import Home Manager modules
          imports = [ ./${hostname}/home.nix ];

          # Home Manager
          home = {
            # User information
            inherit username;
            homeDirectory = "/home/${username}";

            # Don't change this value even if you update Home Manager
            stateVersion = "24.11";
          };

          # Let Home Manager install and manage itself
          programs.home-manager.enable = true;
        };
      };
    }
  ];
}
