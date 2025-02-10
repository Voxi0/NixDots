{ inputs, system, ... }: {
  # Import Nix modules
  imports = [
    ./kitty.nix ./cli.nix ./git.nix ./browser ./nixcord.nix ./music.nix
  ];

  # LazyVim
  home.packages = [ inputs.NixNvim.packages.${system}.nvim ];
}
