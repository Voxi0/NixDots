{ pkgs, ... }: {
  #####################
  ### Extra Plugins ###
  #####################
  programs.nvf.settings.vim = {
    # Keybindings
    maps.normal = {
      # LazyGit
      "<C-g>" = {
        silent = true;
        action = "<cmd>LazyGit<CR>";
      };
      
      # Nvim UFO
      "zR".action = "require('ufo').openAllFolds";
      "zM".action = "require('ufo').closeAllFolds";
    };

    extraPlugins = with pkgs.vimPlugins; {
      plenary.package = plenary-nvim;           # Required for some reason
      lazygit.package = lazygit-nvim;           # TUI for Git
      barbar.package = barbar-nvim;             # Tabline

      # Code folding
      nvim-ufo = {
        package = nvim-ufo;
        setup = "require('ufo').setup()";
      };
    };
  };
}
