{ inputs, system, pkgs, ... }: {
  # Import Nix modules
  imports = [
    ./kitty.nix ./cli.nix ./git.nix ./browser ./nixcord.nix ./music.nix
  ];

  # LazyVim
  home.packages = [ inputs.NixNvim.packages.${system}.nvim ];

  # OBS studio
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };
}
