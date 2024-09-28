{ lib, config, pkgs, ... }: {
  # Module options
  options = {
    neovim.enable = lib.mkEnableOption "Enables Neovim";
  };

  # Configure Neovim if it's enabled
  config = lib.mkIf config.neovim.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

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
        smartindent = true;
        autoindent = false;
        shiftwidth = 4;
        tabstop = 4;
        softtabstop = 4;
        expandtab = true;

        # Faster autocompletion
        updatetime = 100;

        # Set file encoding
        encoding = "utf-8";
        fileencoding = "utf-8";
      };

      # Global options
      globals = {
        # Set leader key to space
        mapleader = " ";
      };

      # Keybinds
      keymaps = [
        {action = "<Cmd>Neotree toggle<CR>"; key = "<C-n>";}
        {action = "<Cmd>LazyGit<CR>"; key = "<C-g>";}
      ];

      # Plugins
      plugins = {
        # Icons
        web-devicons.enable = true;

        # LazyGit
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
              nowait = false;
            };
            "<2-LeftMouse>" = "open";
            "<esc>" = "revert_preview";
            P = {
              command = "toggle_preview";
              config = { use_float = true; };
            };
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

        # Treesitter - Syntax highlighting
        treesitter = {
          enable = true;
          settings = {
            auto_install = true;
            indent.enable = false;
          };
        };

        # LSP
        lsp = {
          enable = true;
          servers = {
            clangd.enable = true;
            ts-ls.enable = true;
            lua-ls.enable = true;
          };
        };

        # Autocompletion
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

        # Noice - Experimental Neovim UI
        noice.enable = true;

        # Lualine
        lualine = {
          enable = true;
          settings.options = {
            theme = "auto";
            icons_enabled = true;
          };
        };

        # Super useful plugins
        nvim-autopairs.enable = true;
        nix.enable = true;
      };
    };
  };
}
