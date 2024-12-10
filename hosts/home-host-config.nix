# This function allows you to easily create new NixOS configurations in the system flake
# This way, you can avoid repeating code and make it much more readable
{ nixpkgs, inputs, system, hostname, username, ...}: inputs.home-manager.lib.homeManagerConfiguration {
  # Packages
  pkgs = nixpkgs.packages.${system};

  # Home Manager modules
  modules = [
    ./${hostname}/home.nix
    {
      home = {
        homeDirectory = "/home/${username}";
        inherit username;
        stateVersion = "24.05";
      };

      # Let Home Manager install and manage itself
      programs.home-manager.enable = true;

      # Pass these to 'home.nix'
      extraSpecialArgs = { inherit inputs; };
    }
  ];
}
