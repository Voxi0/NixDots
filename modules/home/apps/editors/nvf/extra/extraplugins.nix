{ pkgs, ... }: {
  #####################
  ### Extra Plugins ###
  #####################
  programs.nvf.settings.vim = {
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
