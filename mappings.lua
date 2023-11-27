---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<leader>p"] = {"\"+p", "Paste from clipboard"},
  },
  v = {
    [">"] = { ">gv", "indent"},
    ["J"] = { ":m '>+1<CR>gv=gv", "Move selected down" },
    ["K"] = { ":m '<-2<CR>gv=gv", "Move selected up" },
    ["<leader>y"] = {"\"+y", "Copy to clipboard"},
    ["<leader>p"] = {"\"+p", "Paste from clipboard"},
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue the debugger",
    },
  },
}

-- more keybinds!

return M
