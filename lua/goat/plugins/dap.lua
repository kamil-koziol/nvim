return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio", "folke/neodev.nvim" },
  config = function()
    require("dapui").setup()

    require("neodev").setup({
      library = { plugins = { "nvim-dap-ui" }, types = true },
    })

    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- Keymaps
    vim.keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Run or continue debugging" })
    vim.keymap.set("n", "<leader>dus", function()
      local widgets = require("dap.ui.widgets")
      local sidebar = widgets.sidebar(widgets.scopes)
      sidebar.open()
    end, { desc = "Open debugging sidebar" })
  end,
}
