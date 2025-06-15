# Function to easily create new NixOS configurations in the system flake
{ nixpkgs, systemDisk, system, inputs, hostname, username, locale, timezone, kbLayout, ... }: nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs hostname username locale timezone kbLayout; };
  modules = [
    ./${hostname}/configuration.nix {
      # Nix packages
      nixpkgs.config.allowUnfree = true;

      # Nix
      nix = {
        optimise.automatic = true;
        settings = {
          experimental-features = [ "nix-command" "flakes" ];
          auto-optimise-store = true;
					trusted-public-keys = [];
					substituters = [
						"https://cache.nixos.org/"
					];
        };
      };
    }
    inputs.home-manager.nixosModules.home-manager {
      home-manager = {
        useGlobalPkgs = false;
        useUserPackages = true;
        extraSpecialArgs = { inherit system inputs username; };
        backupFileExtension = "bak";

        # User
        users.${username} = {
          # Import Home Manager modules
          imports = [ ./${hostname}/home.nix ];

          # Nix packages
          nixpkgs.config.allowUnfree = true;

          # Home Manager
          home = {
            # User information
            inherit username;
            homeDirectory = "/home/${username}";

            # Don't change this value even if you update Home Manager
            stateVersion = "25.05";
          };

          # Let Home Manager install and manage itself
          programs.home-manager.enable = true;
        };
      };
    }
  ];
}
