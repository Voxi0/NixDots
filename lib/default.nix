_: let
  defaultOverlays = [];
in {
  makeNixosConfig = {
    system,
    inputs,
    overlays ? defaultOverlays,
    hostname,
    username,
    locale,
    kbLayout,
  }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs system hostname username locale kbLayout;};
      modules = [
        # NixOS config
        ../hosts/${hostname}/configuration.nix
        {
          nixpkgs = {
            inherit overlays;
            config.allowUnfree = true;
            hostPlatform = system;
          };
        }

        # Home Manager config
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {inherit inputs system kbLayout username;};
            backupFileExtension = "bak";
            users.${username} = import ../hosts/${hostname}/home.nix;
          };
        }
      ];
    };

  makeHomeManagerConfig = {
    system,
    inputs,
    overlays ? defaultOverlays,
    hostname,
    username,
    kbLayout,
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = {inherit inputs system kbLayout username;};
      backupFileExtension = "bak";
      modules = [../hosts/${hostname}/home.nix];
      pkgs = import inputs.nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };
    };
}
