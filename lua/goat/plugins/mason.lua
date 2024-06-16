return {
  "williamboman/mason.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup()

    mason_tool_installer.setup({
      ensure_installed = {
        -- lua
        "stylua",

        -- web dev
        "prettierd",
        "eslint_d",

        -- python
        "isort",
        "black",
        "pylint",
      },
    })

  end,
}
