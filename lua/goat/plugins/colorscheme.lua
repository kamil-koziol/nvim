return {
  "kamil-koziol/imperial.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme('imperial')
    -- vim.api.nvim_set_hl(0, "MatchParen", { bg = "#222222", fg = "#ffffff", bold = true })
  end,
}
