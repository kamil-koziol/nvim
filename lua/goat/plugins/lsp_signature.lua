return {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  opts = {},
  config = function(_, _)
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        require("lsp_signature").on_attach({
          bind = true,
          hint_prefix = {
            above = "↙ ", -- when the hint is on the line above the current line
            current = "← ", -- when the hint is on the same line
            below = "↖ ", -- when the hint is on the line below the current line
          },
        }, bufnr)
      end,
    })
  end,
}
