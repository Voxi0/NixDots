{ pkgs, ... }: {
  #################
  ### Telescope ###
  #################
  home.packages = with pkgs; [ ripgrep ];
  programs.nvf.settinvs.vim.telescope = {
    enable = true;
    setupOpts.defaults = {
      color_devicons = true;
      initial_mode = "normal";
    };
    mappings = {
      findFiles = "<leader>ff";
      open = "<leader>ft";
      resume = "<leader>fr";
      treesitter = "<leader>fs";
      buffers = "<leader>fb";
      diagnostics = "<leader>fld";
      findProjects = "<leader>fp";

      lspDefinitions = "<leader>flD";
      lspDocumentSymbols = "<leader>flsb";
      lspImplementations = "<leader>fli";
      lspReferences = "<leader>flr";
      lspTypeDefinitions = "<leader>flt";
      lspWorkspaceSymbols = "<leader>flsw";

      gitBranches = "<leader>fvb";
      gitBufferCommits = "<leader>fvcb";
      gitCommits = "<leader>fvcw";
      gitStash = "<leader>fvx";
      gitStatus = "<leader>fvs";

      helpTags = "<leader>fh";
      liveGrep = "<leader>fg";
    };
  };
}
