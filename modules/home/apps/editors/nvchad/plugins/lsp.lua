return {
  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim"
    },
    config = function()
      -- Set up Mason
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })

      -- Set up Mason LSP config
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = { "nix" },
      })

      -- Automatically set up LSPs installed via Mason
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      require("mason-lspconfig").setup_handlers({
        function(serverName)
          require("lspconfig")[serverName].setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
            end,
          })
        end,
      })
    end
  },
}
