{ lib, config, inputs, pkgs, ... }: {
  # Import Nix modules
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  # Module options
  options = {
    enableNeovim = lib.mkEnableOption "Enables Neovim"; 
  };

  # Configure Neovim if it's enabled
  config = lib.mkIf config.enableNeovim {
    programs.nvf = {
      enable = true;
      settings.vim = {
        # Open Neovim whenever "vi" or "vim" command is executed
        viAlias = true;
        vimAlias = true;

        # Follow editorconfig rules in current directory
        enableEditorconfig = true;

        # Enable experimental Lua module loader to speed up the start process
        enableLuaLoader = true;

        # Extra packages to install
        extraPackages = with pkgs; [ wl-clipboard ripgrep ];

        # General
        leaderKey = " ";
        lineNumberMode = "number";
        spellcheck.enable = true;
        colourTerm = true;
        useSystemClipboard = true;              # Required to copy text from Neovim and paste it somewhere else and vice versa
        wordWrap = false;                       # Don't let any text wrap around the screen
        disableArrows = true;                   # Prevent arrow keys from moving the cursor
        visuals = {
          fidget-nvim.enable = true;            # Extensible UI for Neovim notifications and LSP progress messages.
          nvimWebDevicons.enable = true;        # Icons
          scrollBar.enable = true;              # Scrollbar and smooth scrolling
          smoothScroll.enable = true;
        };

        # Keybinds
        binds.cheatsheet.enable = true;
        maps = {
          normal = {
            # LazyGit
            "<C-g>" = {
              silent = true;
              action = "<cmd>LazyGit<CR>";
            };
          };
        };

        # Theme
        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = false;
        };

        # UI
        ui = {
          noice.enable = true;
        };

        # Statusline
        statusline.lualine = {
          enable = true;
          theme = "auto";
        };

        # Treesitter - Syntax highlighting
        treesitter = {
          enable = true;
          addDefaultGrammars = true;
          autotagHtml = true;
          context.enable = false;
          highlight = {
            enable = true;
            additionalVimRegexHighlighting = false;
          };
          fold = false;
          indent.enable = false;
        };

        # LSP
        lsp = {
          enable = true;
          formatOnSave = false;

          lightbulb.enable = true;        # Show code suggestions
          lspSignature.enable = true;     # Shows function signature when you type

          # VSCode like pictograms for Neovim LSP
          lspkind = {
            enable = true;
            mode = "symbol_text";
          };

          # Keybinds
          mappings = {
            # Basics
            hover = "<leader>k";
            codeAction = "<leader>ca";
            format = "<leader>cf";
            toggleFormatOnSave = "<leader>ltf";

            # Diagnostics
            nextDiagnostic = "<leader>lgn";
            previousDiagnostic = "<leader>lgp";
            openDiagnosticFloat = "<leader>le";

            # Don't understand lol
            renameSymbol = "<leader>ln";
            signatureHelp = "<leader>ls";
            goToDeclaration = "<leader>lgD";
            goToDefinition = "<leader>lgd";
            goToType = "<leader>lgt";
            listDocumentSymbols = "<leader>lS";
            listImplementations = "<leader>lgi";
            listReferences = "<leader>lgr";
            listWorkspaceFolders = "<leader>lwl";
            listWorkspaceSymbols = "<leader>lws";
          };

          # Trouble diagnostics viewer
          trouble = {
            enable = true;
            mappings = {
              toggle = "<leader>xx";
              documentDiagnostics = "<leader>ld";
              workspaceDiagnostics = "<leader>lwd";
              lspReferences = "<leader>lr";
              quickfix = "<leader>xq";
              locList = "<leader>xl";
            };
          };
        };

        # File explorer
        filetree.nvimTree = {
          enable = true;
          mappings.toggle = "<C-n>";            # Toggle file explorer with Control + N
          setupOpts = {
            # Disable the default Neovim file explorer
            disable_netrw = true;

            # Indicate which files have unsaved modifications
            modified = {
              enable = true;
              show_on_dirs = true;              # Show modified icons on parent directories
            };

            # Close file explorer upon opening a file and any window displaying a file when removing the file from the tree
            actions = {
              use_system_clipboard = true;      # Use the system clipboard when copy/paste functions are invoked
              open_file.quit_on_open = true;    # Close file explorer upon opening a file
              remove_file.close_window = true;  # Close any window displaying a file when it's removed from the file tree
            };

            # Show LSP and COC diagnostics in the signcolumn - Modified sign takes precedence over this
            diagnostics = {
              enable = true;
              show_on_dirs = true;
            };

            # Filter files in the file explorer
            filters = {
              dotfiles = false;                 # Show files starting with a fullstop
              git_ignored = true;               # Ignore files based on '.gitignore'
            };

            # Git integration
            git = {
              enable = true;
              show_on_dirs = true;              # Show Git icons on parent directories
            };
          };
        };

        # Auto indent, autocompletion, automatically pair characters e.g. "()"
        autoIndent = true;
        autopairs.enable = true;
        autocomplete= {
          enable = true;
          alwaysComplete = true;
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

        # Git integration
        git = {
          enable = true;
          gitsigns.enable = true;
        };

        # Debugging
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
        languages = {
          enableTreesitter = true;
          enableLSP = true;
          enableFormat = true;
          enableDAP = true;
          enableExtraDiagnostics = true;

          nix.enable = true;
          clang.enable = true;
          rust.enable = true;
          html.enable = true;
          css.enable = true;
          ts.enable = true;
          markdown.enable = true;
        };

        # Telescope
        telescope = {
          enable = true;
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
          setupOpts = {
            defaults = {
              color_devicons = true;
              initial_mode = "normal";
            };
          };
        };

        # Discord rich presence
        presence.neocord = {
          enable = true;
          setupOpts = {
            logo = "auto";
            logo_tooltip = "The One True Text Editor";
            main_image = "logo";
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

        # Utilities
        utility = {
          ccc.enable = true;                        # Color picker
          icon-picker.enable = true;
          images.image-nvim = {
            enable = true;                          # Enable image support in Neovim
            setupOpts.backend = "kitty";            # "ueberzug" for other terminals than Kitty
          };
          preview.markdownPreview = {
            enable = true;
            alwaysAllowPreview = true;
            autoStart = true;
            autoClose = true;
            filetypes = [ "markdown" ];
            lazyRefresh = true;
          };
        };
        
        # Extra plugins
        extraPlugins = with pkgs.vimPlugins; {
          plenary.package = plenary-nvim;           # Required for some reason
          barbar.package = barbar-nvim;             # Tabline
          lazygit.package = lazygit-nvim;           # TUI for Git

          # Code folding
          nvim-ufo = {
            package = nvim-ufo;
            setup = "
              -- Keybinds
              vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
              vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

              -- Setup Nvim UFO
              require('ufo').setup()
            ";
          };
        };
      };
    };
  };
}
