return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
  config = function()
    local mason_lspconfig = require("mason-lspconfig")
    local handlers = {
      function(server_name)
        require("lspconfig")[server_name].setup({})
      end,
      ["rust_analyzer"] = function() end, -- disable for rustaceanvim
      ["gopls"] = function()
        local lspconfig = require("lspconfig")
        lspconfig.gopls.setup({
          settings = {
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
              analyses = {
                unusedparams = true,
                unusedvariable = true,
              },
            },
          },
        })
      end,
    }
    mason_lspconfig.setup({
      ensure_installed = {
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
        "tsserver",
        "rust_analyzer",
        "gopls",
      },
      handlers = handlers,
    })
  end,
}
