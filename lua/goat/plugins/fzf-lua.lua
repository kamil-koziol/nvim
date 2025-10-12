return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  config = function()
    vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Fuzzy find all files in cwd" })
    vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua git_files<cr>", { desc = "Fuzzy find git-files in cwd" })
    vim.keymap.set("n", "<leader>fs", "<cmd>FzfLua live_grep_native<cr>", { desc = "Find Files" })
    vim.keymap.set("n", "<leader>gh", "<cmd>FzfLua git_bcommits<cr>", { desc = "Git commits history" })
  end,
}
