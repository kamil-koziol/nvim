-- Options

vim.cmd([[autocmd BufEnter * set formatoptions-=cro]])

vim.opt.relativenumber = true
vim.cmd("set nu rnu")

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

vim.opt.termguicolors = true

vim.opt.updatetime = 50

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.autoread = true

-- Plugins

vim.pack.add({
  "https://github.com/aktersnurra/no-clown-fiesta.nvim",
  "https://github.com/numToStr/Comment.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/nvim-tree/nvim-tree.lua",
})

vim.cmd.colorscheme("no-clown-fiesta")

require("nvim-treesitter.config").setup({
  highlight = { enable = true },
})

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    javascript = { { "prettierd", "prettier" } },
    javascriptreact = { { "prettierd", "prettier" } },
    typescript = { { "prettierd", "prettier" } },
    typescriptreact = { { "prettierd", "prettier" } },
    rust = { "rustfmt" },
    go = { "goimports", "gofmt" },
    markdown = { "prettierd" },
    yaml = { "prettierd" },
  },

  format_on_save = function(bufnr)
    -- Enable autoformat on certain filetypes
    local format_filetypes = { "go", "lua" }

    if not vim.tbl_contains(format_filetypes, vim.bo[bufnr].filetype) then
      return
    end

    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
})

require("gitsigns").setup()

local function open_floating_tool(cmd, on_exit_callback)
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
  })

  -- Use the built-in :terminal command which is the replacement for termopen
  -- We use 'startinsert' to immediately focus the terminal
  vim.cmd("terminal " .. cmd)
  vim.cmd("startinsert")

  -- Track the process to handle the exit callback
  vim.api.nvim_create_autocmd("TermClose", {
    buffer = buf,
    callback = function()
      vim.api.nvim_win_close(win, true)
      vim.cmd("bdelete! " .. buf)
      if on_exit_callback then
        on_exit_callback()
      end
    end,
  })
end

-- Keymaps

vim.g.mapleader = " "

local map = vim.keymap.set

map("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Fuzzy find all files in cwd" })
map("n", "<leader>fg", "<cmd>FzfLua git_files<cr>", { desc = "Fuzzy find git-files in cwd" })
map("n", "<leader>fs", "<cmd>FzfLua live_grep_native<cr>", { desc = "Find Files" })
map("n", "<leader>gh", "<cmd>FzfLua git_bcommits<cr>", { desc = "Git commits history" })

require("nvim-tree").setup({
  update_focused_file = {
    enable = true,
  },
  git = {
    enable = true,
    ignore = false,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
  view = {
    relativenumber = true,
    adaptive_size = true,
    side = "right",
  },

  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  filters = {
    dotfiles = false,
  },
})

map("n", "<C-n>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle tree" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "<leader>fm", function()
  require("conform").format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  })
end, { desc = "Format file" })

map("n", "<leader>lg", function()
  open_floating_tool("lazygit")
end, { desc = "LazyGit" })

map("n", "<leader>gb", "<cmd>:Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle git blame" })

map("v", "<leader>p", '"+p', { desc = "Paste from clipboard" })
map("v", "<leader>y", '"+y', { desc = "Copy to clipboard" })
map("v", ">", ">gv")
map("v", "<", "<gv")

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected down" })
map("v", "K", ":m '>-2<CR>gv=gv", { desc = "Move selected up" })

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })

map("i", "<C-j>", "<nop>")
map("i", "<C-k>", "<nop>")

-- LSP

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.bo[args.buf].formatexpr = nil
    vim.bo[args.buf].omnifunc = nil

    local opts = { silent = true }

    opts.desc = "Go to declaration"
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

    opts.desc = "Show LSP definitions"
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- show lsp definitions

    opts.desc = "See available code actions"
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

    opts.desc = "Smart rename"
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

    opts.desc = "Show line diagnostics"
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

    opts.desc = "Go to previous diagnostic"
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

    opts.desc = "Go to next diagnostic"
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

    opts.desc = "Show documentation for what is under cursor"
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

    opts.desc = "Show documentation for what is under cursor"
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

    opts.desc = "Restart LSP"
    vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
vim.cmd("set completeopt+=noselect")

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})
vim.lsp.enable({
  "lua_ls",
  "gopls",
  "pylsp",
  "ts_ls",
  "svelte",
  "yamlls",
  "buf_ls",
  "tailwindcss",
  "templ",
  "cssls",
})
