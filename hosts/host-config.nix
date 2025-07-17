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
    {
      # Nix/Nixpkgs
      nixpkgs.config.allowUnfree = true;
      nix = {
        optimise.automatic = true;
        settings = {
          trusted-users = ["root" "${username}"];
          experimental-features = ["nix-command" "flakes"];
          auto-optimise-store = true;
        };
      };
    }

    # Home Manager config
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit system inputs kbLayout username;};
        backupFileExtension = "bak";

        # User
        users.${username} = {
          # Import Home Manager modules
          imports = [./${hostname}/home.nix];

          # Home Manager
          home = {
            # User information
            inherit username;
            homeDirectory = "/home/${username}";

            # Never change this value
            stateVersion = "25.05";
          };

          # Let Home Manager install and manage itself
          programs.home-manager.enable = true;
        };
      };
    }
  ];
}
