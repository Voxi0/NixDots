_: {
  ########################
  ### Language Support ###
  ########################
  programs.nvf.settings.vim = {
    treesitter = {
      enable = true;
      addDefaultGrammars = true;
      autotagHtml = true;
      context.enable = false;
      fold = false;
      indent.enable = false;
      highlight = {
        enable = true;
        additionalVimRegexHighlighting = false;
      };
    };
    languages = {
      enableTreesitter = true;
      enableLSP = true;
      enableFormat = true;
      enableDAP = true;
      enableExtraDiagnostics = true;

      nix.enable = true;
      clang.enable = true;
      zig.enable = true;
      rust.enable = true;
      html.enable = true;
      css.enable = true;
      ts.enable = true;
      markdown.enable = true;
      assembly.enable = true;
    };
    lsp = {
      enable = true;
      formatOnSave = false;

      lightbulb.enable = true;							# Show code suggestions
      lspSignature.enable = true;						# Shows function signature when you type
      lsplines.enable = true;								# Show LSP diagnostics using virtual lines on top of the real line of code

      # VSCode like pictograms for Neovim LSP
      lspkind = {
        enable = true;
        setupOpts.mode = "symbol_text";
      };

      # Keybinds
      mappings = {
        hover = "<leader>k";
        codeAction = "<leader>ca";
        format = "<leader>cf";
      };
    };
    debugger.nvim-dap = {
      enable = true;
      ui = {
        enable = true;
        autoStart = true;
      };
      mappings = {
        toggleBreakpoint = "<leader>db";
        toggleDapUI = "<leader>du";
        toggleRepl = "<leader>dr";

        continue = "<leader>dc";
        hover = "<leader>dh";
        restart = "<leader>dR";

        runLast = "<leader>d.";
        runToCursor = "<leader>dgc";

        stepInto = "<leader>dgi";
        stepOut = "<leader>dgo";
        stepBack = "<leader>dgk";
        stepOver = "<leader>dgj";
        
        terminate = "<leader>dq";
      };
    };
  };
}
