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
					trusted-public-keys = [];
					substituters = [ "https://cache.nixos.org" ];
        };
      };
    }
  ];
}
