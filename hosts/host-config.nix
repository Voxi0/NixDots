# Function to easily create new NixOS configurations in the system flake
{ nixpkgs, system, inputs, hostname, username, locale, kbLayout, ... }: nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs hostname username locale kbLayout; };
  modules = [
    ./${hostname}/configuration.nix {
      # Nix/Nixpkgs
      nixpkgs.config.allowUnfree = true;
      nix = {
        optimise.automatic = true;
        settings = {
          experimental-features = [ "nix-command" "flakes" ];
          auto-optimise-store = true;
					substituters = [ "https://cache.nixos.org" "https://hyprland.cachix.org" ];
					trusted-substituters = [ "https://hyprland.cachix.org" ];
					trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
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
