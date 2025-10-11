return {
    "numToStr/FTerm.nvim",
    lazy = true,
    keys = {
        { "<leader>lg", desc = "Open LazyGit in Floating Terminal" },  -- lazy-load on key
    },
    config = function()
      local FTerm = require("FTerm")

      FTerm.setup({
        border = 'double',
        dimensions = { width = 0.9, height = 0.9 },
      })

      -- Dedicated LazyGit terminal
      local lazygit = FTerm:new({
        cmd = "lazygit",
        dimensions = { width = 0.9, height = 0.9 },
        border = "double",
        auto_close = true,
        cwd = vim.fn.getcwd(),
      })

      -- Keybinding to toggle LazyGit
      vim.keymap.set("n", "<leader>lg", function()
        lazygit:toggle()
      end, { desc = "Open LazyGit in Floating Terminal" })
    end,
}

