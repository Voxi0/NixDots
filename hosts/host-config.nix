# Function to easily create new NixOS configurations in the system flake
{
  inputs,
  system,
  hostname,
  username,
  locale,
  kbLayout,
  ...
}:
inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = {inherit inputs system hostname username locale kbLayout;};
  modules = [
    # NixOS config
    ./${hostname}/configuration.nix

    # Home Manager config
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit inputs system kbLayout username;};
        backupFileExtension = "bak";
        users.${username} = import ./${hostname}/home.nix;
      };
    }
  ];
}
