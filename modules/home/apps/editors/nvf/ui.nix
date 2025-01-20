_: {
  ##########
  ### UI ###
  ##########
  settings.vim = {
    notify.nvim-notify.enable = true;
    # Visuals
    visuals = {
      nvim-web-devicons.enable = true;      # Icons
      nvim-scrollbar.enable = true;         # Scrollbar and smooth scrolling
      indent-blankline.enable = true;
      cinnamon-nvim.enable = true;
      cellular-automaton = {
        enable = true;
        mappings.makeItRain = "<leader>mir";
      };
    };
    ui = {
      noice.enable = true;
      breadcrumbs.enable = true;
      colorizer.enable = true;
      fastaction.enable = true;
    };
    statusline.lualine = {
      enable = true;
      theme = "auto";
    };
  };
}
