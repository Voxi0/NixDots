_: {
  ##########
  ### UI ###
  ##########
  programs.nvf.settings.vim = {
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
      transparent = false;
    };
    visuals = {
      nvim-web-devicons.enable = true;  # Icons
      indent-blankline.enable = true;   # Shows indentation visually
    };
    ui = {
      noice.enable = true;              # Highly experimental plugin overriding default Neovim UI
      breadcrumbs.enable = true;        # Provides code context in the winbar
      colorizer.enable = true;          # High-performance color highlighter for Neovim
    };

    statusline.lualine.enable = true;   # A blazing fast and easy to configure Neovim statusline written in pure Lua
    notify.nvim-notify.enable = true;   # A fancy, configurable, notification manager for Neovim
  };
}
