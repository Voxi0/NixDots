# Function to easily create new NixOS configurations in the system flake
{
  nixpkgs,
  system,
  inputs,
  hostname,
  username,
  locale,
  kbLayout,
  ...
}:
nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = {inherit system inputs hostname username locale kbLayout;};
  modules = [
    # NixOS config
    ./${hostname}/configuration.nix

    # Flatpak for Sober (Roblox client)
    inputs.nix-flatpak.nixosModules.nix-flatpak

    # Extra optimizations and stuff for gaming
    inputs.nix-gaming.nixosModules.wine
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    inputs.nix-gaming.nixosModules.platformOptimizations

    # Home Manager config
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit system inputs kbLayout username;};
        backupFileExtension = "bak";
        users.${username} = {
          imports = [
            ./${hostname}/home.nix
            inputs.stylix.homeModules.stylix
            inputs.spicetify-nix.homeManagerModules.spicetify
            inputs.nixcord.homeModules.nixcord
          ];
        };
      };
    }
  ];
}
