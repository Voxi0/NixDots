{ config, pkgs, ... }: {
  # Nixvim Config
  programs.nixvim = {
    # Enable/Disable Nixvim and Set it as The Default Editor
    enable = true;
    defaultEditor = true;

    # Enable Vi and Vim Alias - Open Neovim When 'vi' or 'vim' is Entered in The Terminal
    viAlias = true;
    vimAlias = true;

    # Theme/Colorscheme
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        transparent_background = false;
        background = {
          light = "frappe";
          dark = "mocha";
        };
        integrations = {
          cmp = true;
          gitsigns = true;
          mini.enabled = true;
          notify = true;
          treesitter = true;
        };
      };
    };

    # Options
    opts = {
      # Enable/Disable Truecolors
      termguicolors = true;

      # Line Numbering
      number = true;
      relativenumber = false;

      # Indentation
      smartindent = false;
      autoindent = false;
      shiftwidth = 4;
      tabstop = 4;
      expandtab = false;

      # Code Folding
      foldmethod = "indent";
      foldenable = false;
      foldlevel = 99;

      # Faster Autocompletion
      updatetime = 100;

      # Mouse Options
      mouse = "a";            # Enable Mouse Control
      mousemodel = "extend";  # Mouse RMB Extends The Current Selection

      # Set encoding type
      encoding = "utf-8";
      fileencoding = "utf-8";
    };

    # Global Options
    globals = {
      # Set Leader Key to Space
      mapleader = " ";
    };

    # Keybinds
    keymaps = [
      # NvimTree
      {action = "<Cmd>NvimTreeToggle<CR>"; key = "<C-n>";}
    ];

    # Plugins
    plugins = {
      # Dashboard
      alpha = {
        enable = true;
        iconsEnabled = true;
        theme = "dashboard";
      };

      # NvimTree - File Explorer
      nvim-tree = {
        enable = true;
        disableNetrw = true;
        git.enable = true;
      };

      # Treesitter - Syntax Highlighting
      treesitter = {
        enable = true;
        indent = false;
      };

      # LSP
      lsp = {
        enable = true;

        # Language Servers
        servers = {
          clangd.enable = true;
          rust-analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          tsserver.enable = true;
          lua-ls.enable = true;
        };

        # Keybinds
        keymaps = {
          silent = true;
          lspBuf = {
            K = "hover";
            "<leader>ca" = "code_action";
            "<leader>rn" = "rename";
          };
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
        settings = {
          snippet.expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
          mapping = {
            __raw = ''
              cmp.mapping.preset.insert ({
                ["<CR>"] = cmp.mapping.confirm({select = false}),
                ["<C-e>"] = cmp.mapping.close(),
              })
            '';
          };

          sources = [
            {name = "path";}
            {name = "nvim_lsp";}
            {name = "nvim_lua";}
            {name = "luasnip";}
            {name = "buffer";}
          ];
        };
      };

      # Bufferline
      bufferline = {
        # Enable Plugin and Make it Possible to Theme
        enable = true;
        themable = true;

        # Choose What to Show
        alwaysShowBufferline = true;
        showBufferIcons = true;
        showBufferCloseIcons = true;

        # Tab-Separator Style
        separatorStyle = "slope";

        # Tab Sort
        sortBy = "insert_after_current";
        persistBufferSort = false;

        # Diagnostics
        diagnostics = "nvim_lsp";
      };

      # Lualine
      lualine = {
        enable = true;
        iconsEnabled = true;
      };

      # Super Useful Plugins
      nvim-autopairs.enable = true;
      nix.enable = true;
      comment = {
        enable = true;
        settings = {
          opleader.line = "gcc";
          toggler.line = "gcc";
        };
      };
    };
  };
}
