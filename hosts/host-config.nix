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

    # Home Manager config
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit system inputs kbLayout username;};
        backupFileExtension = "bak";
        users.${username} = import ./${hostname}/home.nix;
      };
    }
  ];
}
