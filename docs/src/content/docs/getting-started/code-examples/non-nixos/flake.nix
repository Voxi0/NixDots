{
  description = "Standalone Home Manager config on Non-NixOS machine that uses NixDots";
  inputs = {
    NixDots = {
      url = "github:Voxi0/NixDots";

      # If you define your own Nixpkgs, this also applies to all other NixDots inputs e.g. Home Manager
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = _: let
    system = "x86_64-linux";

    # We're using the Nixpkgs defined in NixDots but you can use your own Nixpkgs if you wish
    pkgs = import inputs.NixDots.inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    # Just for convenience
    nixdotsHomeModules = inputs.NixDots.homeManagerModules;

    # REQUIRED FOR NIXDOTS TO WORK
    username = "your-username";
    kbLayout = "us";
  in {
    homeConfigurations.${username} = inputs.NixDots.inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        # So you can avoid having to define any inputs that NixDots requires, using it's own inputs instead
        inherit (inputs.NixDots) inputs;

        # REQUIRED FOR NIXDOTS TO WORK
        inherit system username kbLayout;
      };
      modules = [
        # Your Home Manager config
        ./home.nix

        # Choose whatever modules you desire
        # Every single module
        nixdotsHomeModules.default

        # Window manager / Desktop environments and theming/styling
        nixdotsHomeModules.desktops
        nixdotsHomeModules.stylix

        # My wallpaper collection
        nixdotsHomeModules.wallpapers

        # CLI stuff
        nixdotsHomeModules.fish
        nixdotsHomeModules.cli.default
        nixdotsHomeModules.cli.git
        nixdotsHomeModules.cli.fastfetch
        nixdotsHomeModules.cli.ncmpcpp
        nixdotsHomeModules.cli.yazi

        # Apps
        nixdotsHomeModules.apps.default
        nixdotsHomeModules.apps.kitty
        nixdotsHomeModules.apps.browser
        nixdotsHomeModules.apps.spotify
        nixdotsHomeModules.apps.discord
      ];
    };
  };
}
