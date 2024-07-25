return {
  "aktersnurra/no-clown-fiesta.nvim",
  priority = 1000,
  config = function()
    vim.cmd("colorscheme no-clown-fiesta")
    vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#999999", bold = false })
    vim.api.nvim_set_hl(0, "LineNr", { fg = "white", bold = true })
    vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#999999", bold = false })
    vim.cmd("hi StatusLine guifg=#999999")
  end,
}
