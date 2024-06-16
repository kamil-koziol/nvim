return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
  config = function()
    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
      ensure_installed = {
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
        "tsserver",
        "rust_analyzer",
      },
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({})
      end,
      ["rust_analyzer"] = function() end, -- disable for rustaceanvim
    })
  end,
}
