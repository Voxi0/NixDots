{ lib, config, pkgs, ... }: {
  # Module options
  options.neovim.enable = lib.mkEnableOption "Enables Neovim";

  # Configure Neovim if it's enabled
  config = lib.mkIf config.neovim.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      # Extra dependencies
      extraPackages = with pkgs; [ wl-clipboard ];

      # Colorscheme
      colorschemes.catppuccin = {
        enable = true;
        settings = {
          term_colors = true;
          transparent_background = false;
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
        # Enable/Disable truecolors disable text wrapping and enable line numbering
        termguicolors = true;
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
        foldmethod = "expr";                      # Set folding method to expression
        foldexpr = "nvim_treesitter#foldexpr()";  # Use Treesitter for folding
        foldlevel = 10;                           # How many folds to keep open when a new file is opened
        foldcolumn = "0";
        foldtext = "";
        fillchars.fold = " ";                     # Set to a space to avoid trailing dots

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
        {action = "<Cmd>Neotree toggle<CR>"; mode = [ "n" "v" ]; key = "<C-n>";}
        {action = "<Cmd>LazyGit<CR>"; mode = [ "n" ]; key = "<C-g>";}
      ];

      # Plugins
      plugins = {
        # Icons, Noice (Experimental Neovim UI) and Lualine (Statusline for Neovim)
        web-devicons.enable = true;
        noice.enable = true;
        lualine = {
          enable = true;
          settings.options = {
            theme = "auto";
            icons_enabled = true;
          };
        };


        # NeoTree - File explorer
        neo-tree = {
          enable = true;
          enableDiagnostics = true;
          enableGitStatus = true;
          enableModifiedMarkers = true;
          useDefaultMappings = false;
          window.mappings = {
            "<tab>" = {
              command = "open";
              # disable `nowait` if you have existing combos starting with this char that you want to use
              nowait = true;
            };
            "<2-LeftMouse>" = "open";

            # Preview file on hover
            P = {
              command = "toggle_preview";
              config = { use_float = true; };
            };
            "<esc>" = "revert_preview";
            l = "focus_preview";
            S = "open_split";
            # S = "split_with_window_picker";
            s = "open_vsplit";
            # s = "vsplit_with_window_picker";
            t = "open_tabnew";
            # "<cr>" = "open_drop";
            # t = "open_tab_drop";
            w = "open_with_window_picker";
            C = "close_node";
            z = "close_all_nodes";
            # Z = "expand_all_nodes";
            R = "refresh";
            a = {
              command = "add";
              # some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = "none"; # "none", "relative", "absolute"
              };
            };
            d = "delete";
            r = "rename";
            y = "copy_to_clipboard";
            x = "cut_to_clipboard";
            p = "paste_from_clipboard";
            c = "copy"; # takes text input for destination, also accepts the config.show_path and config.insert_as options
            m = "move"; # takes text input for destination, also accepts the config.show_path and config.insert_as options
            e = "toggle_auto_expand_width";
            q = "close_window";
            "?" = "show_help";
            "<" = "prev_source";
            ">" = "next_source";
          };
        };
        
        # Treesitter syntax highlighting and LSP
        treesitter = {
          enable = true;
          settings = {
            auto_install = true;
            indent.enable = true;
            fold.enable = true;
          };
        };
        lsp = {
          enable = true;
          servers = {
            nixd.enable = true;
            clangd.enable = true;
            ts-ls.enable = true;
            lua-ls.enable = true;
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
            snippet.expand = ''
              function(args)
                require("luasnip").lsp_expand(args.body)
              end
            '';
          };
        };

        # Super useful plugins
        nvim-autopairs.enable = true;
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