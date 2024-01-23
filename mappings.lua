---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<leader>p"] = { '"+p', "Paste from clipboard" },
  },
  v = {
    [">"] = { ">gv", "indent" },
    ["J"] = { ":m '>+1<CR>gv=gv", "Move selected down" },
    ["K"] = { ":m '<-2<CR>gv=gv", "Move selected up" },
    ["<leader>y"] = { '"+y', "Copy to clipboard" },
    ["<leader>p"] = { '"+p', "Paste from clipboard" },
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

M.harpoon = {
  n = {
    ["<leader>a"] = {
      function()
        require("harpoon"):list():append()
      end,
      "Harpoon add",
    },
    ["<C-e>"] = {
      function()
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
          local file_paths = {}
          for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
          end

          require("telescope.pickers")
              .new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table {
                  results = file_paths,
                },
                previewer = conf.file_previewer {},
                sorter = conf.generic_sorter {},
              })
              :find()
        end
        local harpoon = require "harpoon"
        harpoon.ui:toggle_quick_menu(harpoon:list())
        -- toggle_telescope(harpoon:list())
      end,
      "Open Harpoon window",
    },

    ["<leader>1"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():select(1)
      end,
      "Select 1 harpoon window",
    },

    ["<leader>2"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():select(2)
      end,
      "Select 2 harpoon window",
    },
    ["<leader>3"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():select(3)
      end,
      "Select 3 harpoon window",
    },
    ["<leader>4"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():select(4)
      end,
      "Select 4 harpoon window",
    },
  },
}

return M
