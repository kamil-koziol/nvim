-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

vim.cmd [[autocmd BufEnter * set formatoptions-=cro]]

vim.opt.relativenumber = true
vim.opt.clipboard = ""

