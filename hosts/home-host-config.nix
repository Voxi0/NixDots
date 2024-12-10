# This function allows you to easily create new NixOS configurations in the system flake
# This way, you can avoid repeating code and make it much more readable
{ nixpkgs, inputs, system, hostname, username, ...}: inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  modules = [
    ./${hostname}/home.nix
    # User information
    inputs.home-manager.home {
      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
        stateVersion = "24.05";
      };

      # Let Home Manager install and manage itself
      programs.home-manager.enable = true;
    }
  ];
}
