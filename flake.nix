{
  description = "NixDots";

  # Nix
  nixConfig = {
    extra-substituters = [
      "https://hyprland.cachix.org" # Hyprland
      "https://nix-gaming.cachix.org" # Nix gaming
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" # Hyprland
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" # Nix gaming
    ];
  };

  # Dependencies
  inputs = {
    # Nix packages repository and declarative Flatpak manager
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    # Manages user-level configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # System-wide theming and typography
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # Firefox extensions
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # My personal Neovim configuration using nixCats
    NixNvim = {
      url = "github:Voxi0/NixNvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Gaming related stuff
    nix-gaming.url = "github:fufexan/nix-gaming";

    # Declaratively configure Vencord and it's plugins
    nixcord.url = "github:kaylorben/nixcord";

    # Multiplatform CLI tool to customize the official Spotify client
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  # Actions to perform after fetching all dependencies
  outputs = inputs: let
    system = "x86_64-linux";
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    username = "voxi0";
    locale = "en_GB.UTF-8";
    kbLayout = "gb";
    mkSystem = {hostname}:
      import ./hosts/host-config.nix {
        inherit system inputs hostname username locale kbLayout;
      };
  in {
    # Devtools - For working with NixDots, use command `nix develop` to start the devshell
    formatter.${system} = pkgs.alejandra;
    devShells.${system}.default = pkgs.mkShellNoCC {
      buildInputs = with pkgs; [
        inputs.NixNvim.packages.${system}.nvim # My custom Neovim configuration made with Nix and nixCats
        git # Version control system
        deadnix # Catches unused/dead Nix code
        statix # Lints and suggestions for the Nix language
      ];
    };

    # Export all custom NixOS/Home Manager modules so they can be used by other flakes
    nixosModules = rec {
      default = import ./modules/nixos;
    };
    homeManagerModules = rec {
      default = import ./modules/home;
      wallpapers = import ./modules/home/wallpapers;
      stylix = import ./modules/home/stylix.nix;
      desktops = import ./modules/home/desktops;

      # CLI
      fish = import ./modules/home/fish.nix;
      cli = {
        default = import ./modules/home/cli/default.nix;
        git = import ./modules/home/git.nix;
        fastfetch = import ./modules/home/cli/fastfetch.nix;
        ncmpcpp = import ./modules/home/cli/ncmpcpp.nix;
        yazi = import ./modules/home/cli/yazi.nix;
      };

      # Apps
      apps = {
        default = import ./modules/home/apps/default.nix;
        kitty = import ./modules/home/apps/kitty.nix;
        browser = import ./modules/home/apps/browser;
        spotify = import ./modules/home/apps/spotify.nix;
        discord = import ./modules/home/apps/discord.nix;
      };
    };

    # NixOS hosts
    nixosConfigurations = {
      laptop = mkSystem {hostname = "laptop";};
      desktop = mkSystem {hostname = "desktop";};
    };
  };
}
