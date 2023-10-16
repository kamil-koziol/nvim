---@type MappingsTable
local M = {}

M.general = {
  n = {
  --  [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
  v = {
    [">"] = { ">gv", "indent"},
    ["J"] = { ":m '>+1<CR>gv=gv", "Move selected down" },
    ["K"] = { ":m '<-2<CR>gv=gv", "Move selected up" },
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
