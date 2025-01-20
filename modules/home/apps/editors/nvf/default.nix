{ lib, config, inputs, pkgs, ... }: {
  # Import Nix modules
  imports = [
    inputs.nvf.homeManagerModules.default
    ./settings.nix
    ./ui.nix
    ./language.nix
    ./nvimtree.nix
    ./utilities.nix
    ./extraplugins.nix
  ];

  # Module options
  options.enableNeovim = lib.mkEnableOption "Enables Neovim"; 

  # Configure Neovim if it's enabled
  config = lib.mkIf config.enableNeovim {
    # Extra packages that are required
    home.packages = with pkgs; [ wl-clipboard ripgrep ];

    # NVF configuration
    programs.nvf = {
      enable = true;
      settings.vim = {
        # Keybinds
        binds.cheatsheet.enable = true;
        maps = {
          normal = {
            # LazyGit
            "<C-g>" = {
              silent = true;
              action = "<cmd>LazyGit<CR>";
            };

            # Nvim UFO
            "zR".action = "require('ufo').openAllFolds";
            "zM".action = "require('ufo').closeAllFolds";
          };
        };
      };
    };
  };
}
