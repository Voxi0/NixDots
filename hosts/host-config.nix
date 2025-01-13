# This function allows you to easily create new NixOS configurations in the system flake
# This way, you can avoid repeating code and make it much more readable
{ nixpkgs, inputs, system, hostname, username, email, ... }: nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs username; };
  modules = [
    ./${hostname}/configuration.nix
		inputs.disko.nixosModules.default
    inputs.home-manager.nixosModules.home-manager {
      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        extraSpecialArgs = { inherit inputs username email; };
        users."${username}" = {
          # Import Home Manager modules
          imports = [ ./${hostname}/home.nix ];

          # User information
          home = {
            username = "${username}";
            homeDirectory = "/home/${username}";
            stateVersion = "25.05";
          };

          # Let Home Manager install and manage itself
          programs.home-manager.enable = true;
        };
      };
    }
  ];
}
