return { 
  'olivercederborg/poimandres.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('poimandres').setup {}
  end,

  -- optionally set the colorscheme within lazy config
  init = function()
    vim.cmd("colorscheme poimandres")
    vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#222233" })
    vim.api.nvim_set_hl(0, 'MatchParen', { bg = '#222222', fg = '#ffffff', bold = true })
  end
}
