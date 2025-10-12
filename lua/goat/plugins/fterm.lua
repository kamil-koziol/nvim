return {
    "numToStr/FTerm.nvim",
    lazy = true,
    keys = {
        { "<leader>lg", desc = "Open LazyGit in Floating Terminal" },  -- lazy-load on key
        { "<leader>lf", desc = "Open LF in Floating Terminal" },
    },
    config = function()
      local FTerm = require("FTerm")

      FTerm.setup({
        dimensions = { width = 0.9, height = 0.9 },
      })

      -- Dedicated LazyGit terminal
      local lazygit = FTerm:new({
        cmd = "lazygit",
        dimensions = { width = 0.9, height = 0.9 },
        auto_close = true,
        cwd = vim.fn.getcwd(),
      })

      local lf = FTerm:new({
          cmd = "sh -c 'lf -print-selection > /tmp/lf_selection'", -- save selection to temp file
          dimensions = { width = 0.9, height = 0.9 },
          auto_close = true,
          cwd = vim.fn.getcwd(),
          on_exit = function()
              local f = io.open("/tmp/lf_selection", "r")
              if f then
                  local file = f:read("*l")
                  f:close()
                  os.remove("/tmp/lf_selection")
                  if file and file ~= "" then
                      vim.cmd("edit " .. file)
                  end
              end
          end,
      })

      vim.keymap.set("n", "<leader>lg", function()
        lazygit:toggle()
      end, { desc = "Open LazyGit in Floating Terminal" })

      vim.keymap.set("n", "<leader>lf", function()
        lf:toggle()
      end, { desc = "Open LF in Floating Terminal" })
    end,
}

