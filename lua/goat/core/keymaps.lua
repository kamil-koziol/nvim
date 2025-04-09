vim.g.mapleader = " "

-- Enable mappings

local map = vim.keymap.set

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("v", "<leader>p", '"+p', { desc = "Paste from clipboard" })
map("v", "<leader>y", '"+y', { desc = "Copy to clipboard" })
map("v", ">", ">gv")
map("v", "<", "<gv")

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected down" })
map("v", "K", ":m '>-2<CR>gv=gv", { desc = "Move selected up" })

map("i", "<C-k>", vim.lsp.buf.signature_help)
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })

map("n", "<leader>ir", "<cmd>IfErr<CR>", { desc = "IfErr snippet" })

-- Open lazygit in new tmux window
vim.keymap.set(
  "n",
  "<leader>lg",
  '<cmd>silent !tmux set -w popup-border-lines rounded; tmux popup -E -eTERM=screen-256color -xC -yC -w90\\% -h90\\% -d "'
    .. vim.fn.getcwd()
    .. '" lazygit --debug<cr>',
  { desc = "Lazygit" }
)

-- Disable mappings
local nomap = vim.keymap.del
