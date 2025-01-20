_: {
  #################
  ### Utilities ###
  #################
  programs.nvf.settings.vim = {
    autopairs.nvim-autopairs.enable = true;
    autocomplete.nvim-cmp = {
      enable = true;
      mappings = {
        close = "<C-e>";
        complete = "<C-Space>";
        confirm = "<CR>";
        next = "<Tab>";
        previous = "<S-Tab>";
        scrollDocsUp = "<C-d>";
        scrollDocsDown = "<C-f>";
      };
    };
    utility = {
      ccc.enable = true;                        # Color picker
      icon-picker.enable = true;
      images.image-nvim = {
        enable = true;                          # Enable image support in Neovim
        setupOpts.backend = "kitty";            # "ueberzug" for other terminals than Kitty
      };
    };
  };
}
