{ lib, config, pkgs, ... }: {
  # Module options
  options.neovim.enable = lib.mkEnableOption "Enables Neovim";

  # Configure Neovim if it's enabled
  config = lib.mkIf config.neovim.enable {
    stylix.targets.nixvim.enable = false;
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      # Extra dependencies
      extraPackages = with pkgs; [ wl-clipboard ripgrep ];

      # Colorscheme
      colorschemes.catppuccin = {
        enable = true;
        settings = {
          borderless_telescope = true;
          italic_comments = true;
          terminal_colors = true;
          transparent = false;
          background = {
            light = "latte";
            dark = "mocha";
          };
          integrations = {
            cmp = true;
            gitsigns = true;
            mini = {
              enabled = true;
              indentscope_color = "";
            };
            notify = true;
            nvimtree = true;
            treesitter = true;
          };
        };
      };

      # Options
      opts = {
        # Disable text wrapping and enable line numbering
        wrap = false;
        number = true;
        relativenumber = false;

        # Indentation
        smartindent = false;
        autoindent = false;
        shiftwidth = 2;
        tabstop = 2;
        softtabstop = 2;
        expandtab = true;

        # Faster autocompletion
        updatetime = 100;

        # Code folding
        foldenable = true;      # Enable folding
        foldcolumn = "1";       # Show fold column
        foldlevel = 99;         # Start with all folds open
        foldlevelstart = 99;    # Ensure all folds are open by default
        foldmethod = "manual";  # Let nvim-ufo handle folding methods

        # Clipboard
        clipboard = "unnamedplus";

        # Set file encoding
        encoding = "utf-8";
        fileencoding = "utf-8";
      };

      # Set the leader key to space
      globals.mapleader = "<Space>";

      # Keybinds
      keymaps = [
        # Toggle Neotree/LazyGit
        {action = "<Cmd>NvimTreeToggle<CR>"; mode = [ "n" "v" ]; key = "<C-n>";}
        {action = "<Cmd>LazyGit<CR>"; mode = [ "n" ]; key = "<C-g>";}

        # Code folding
        {action = "require('ufo').openAllFolds"; mode = [ "n" ]; key = "zR";}
        {action = "require('ufo').closeAllFolds"; mode = [ "n" ]; key = "zM";}
      ];

      # Plugins
      plugins = {
        # Discord rich presence for Neovim/Nixvim
        neocord = {
          enable = true;
          settings = {
            # Logo
            logo = "auto";
            logo_tooltip = null;
            main_image = "language";
            enable_line_number = false;

            show_time = true;   # Show the timer - How long you're using Neovim
            auto_update = true; # Update activity based on autocmd events

            # Rich presence text
            terminal_text = "Using The Terminal...";
            editing_text = "Editing %s";
            file_explorer_text = "Browsing %s";
            workspace_text = "Working on %s";
            git_commit_text = "Committing...";
            plugin_manager_text = "Managing plugins...";
          };
        };

        # UI
        barbar.enable = true;         # Tabline
        web-devicons.enable = true;   # Icons

        # Experimental Neovim UI and nvim-notify required for noice.nvim
        noice = {
          enable = true;
          lsp.override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
            "cmp.entry.get_documentation" = true;
          };
        };
        notify = {
          enable = true;
          fps = 60; 
          level = "info"; # Minimum log level to display
        };

        # Greeter/Dashboard
        alpha = {
          enable = true;
          theme = "dashboard";
        };

        # Statusbar
        lualine = {
          enable = true;
          settings.options = {
            theme = "auto";
            icons_enabled = true;
          };
        };

        # NeoTree - File explorer
        nvim-tree = {
          enable = true;
          disableNetrw = true;
          hijackCursor = false;
          sortBy = "name";
          actions = {
            changeDir.enable = false;
            openFile.quitOnOpen = true;     # Close the tree when opening a file
            removeFile.closeWindow = true;  # Close any window displaying a file when removing the file from the tree
            useSystemClipboard = true;
          };
        };

        # Syntax highlighting
        treesitter = {
          enable = true;
          settings = {
            auto_install = true;
            indent.enable = true;
            fold.enable = false;
          };
        };

        # LSP
        lsp = {
          enable = true;
          servers = {
            nixd.enable = true;     # Nix
            clangd.enable = true;   # C/C++
            html.enable = true;     # HTML
            ts-ls.enable = true;    # Typescript
          };
        };

        # A pretty Diagnostics, references, telescope results, quickfix and location list
        trouble = {
          enable = true;
          settings = {
            mode = "workspace_diagnostics";
            position = "bottom";
            icons = false;
            indent_lines = true;
            auto_close = true;              # Auto close if there's no diagnostics
          };
        };

        # Snippets and autocompletion
        luasnip.enable = true;
        cmp_luasnip.enable = true;
        cmp-path.enable = true;
        cmp-nvim-lsp.enable = true;
        cmp-buffer.enable = true;
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            sources = [
              {name = "nvim_lsp";}
              {name = "nvim_lua";}
              {name = "luasnip";}
              {name = "path";}
              {name = "buffer";}
            ];
            snippet.expand = "luasnip";
          };
        };

        # Super useful plugins
        nvim-autopairs.enable = true;   # Autoclose symbols
        indent-blankline.enable = true; # Indent lines
        nvim-ufo.enable = true;         # Code folding
        spectre.enable = true;          # Search and replace
        vim-css-color.enable = true;    # CSS color picker
        lazygit = {
          enable = true;
          settings = {
            floating_window_border_chars = [
              "╭"
              "─"
              "╮"
              "│"
              "╯"
              "─"
              "╰"
              "│"
            ];
          };
        };
      };
    };
  };
}
