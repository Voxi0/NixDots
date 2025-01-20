{ pkgs, ... }: {
  settings.vim = {
    # Git integration
    git = {
      enable = true;
      gitsigns.enable = true;
    };
    
    # Telescope
    telescope = {
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

    # Discord rich presence
    presence.neocord = {
      enable = true;
      setupOpts = {
        logo = "auto";
        logo_tooltip = "The One True Text Editor";
        main_image = "language";
        show_time = true;
        auto_update = true;
        enable_line_number = false;

        # Rich presence text
        editing_text = "Editing %s";
        reading_text = "Reading %s";
        file_explorer_text = "Browsing %s";
        workspace_text = "Working on %s";
        terminal_text = "Working on The Terminal...";
        git_commit_text = "Committing Changes...";
        line_number_text = "Line %s Out of %s";
        plugin_manager_text = "Managing Plugins...";
      };
    };
    
    # Extra plugins
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
