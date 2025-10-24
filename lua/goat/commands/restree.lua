vim.api.nvim_create_user_command("Restree", function()
  local filepath = vim.fn.expand("%:p")
  vim.cmd("vsplit | wincmd l | enew")
  local buf = vim.api.nvim_get_current_buf()

  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.bo[buf].modifiable = false
  vim.bo[buf].readonly = true

  vim.api.nvim_buf_set_keymap(buf, "n", "q", ":q<CR>", { noremap = true, silent = true })

  -- First get the curl command from restree output
  vim.system({ "restree", filepath }, { text = true }, function(restree_res)
    if restree_res.code ~= 0 then
      vim.schedule(function()
        vim.bo[buf].modifiable = true
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(restree_res.stderr or "[restree failed]", "\n"))
        vim.bo[buf].modifiable = false
      end)
      return
    end

    -- Convert to curl command using http2curl
    vim.system({ "http2curl", "-args", "-D -" }, { text = true, stdin = restree_res.stdout }, function(curl_res)
      if curl_res.code ~= 0 then
        vim.schedule(function()
          vim.bo[buf].modifiable = true
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(curl_res.stderr or "[http2curl failed]", "\n"))
          vim.bo[buf].modifiable = false
        end)
        return
      end

      -- Execute the curl command string via bash
      vim.system({ "bash", "-c", curl_res.stdout }, { text = true }, function(exec_res)
        vim.schedule(function()
          if not vim.api.nvim_buf_is_valid(buf) then
            return
          end

          vim.bo[buf].modifiable = true
          local lines = {}

          if exec_res.stdout then
            vim.list_extend(lines, vim.split(exec_res.stdout, "\n", { plain = true }))
          end
          if exec_res.code ~= 0 then
            vim.list_extend(lines, vim.split(exec_res.stderr or "[Execution failed]", "\n", { plain = true }))
            table.insert(lines, "[exit code: " .. exec_res.code .. "]")
          end

          -- Set initial output
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

          -- Append restree source at the bottom
          local restree_lines = {
            "",
            "--- restree command output (for reference) ---",
          }
          vim.list_extend(restree_lines, vim.split(restree_res.stdout or "[empty]", "\n", { plain = true }))
          vim.api.nvim_buf_set_lines(buf, -1, -1, false, restree_lines)

          vim.bo[buf].modifiable = false
        end)
      end)
    end)
  end)
end, {})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "http",
  callback = function()
    vim.keymap.set("n", "<leader>r", ":Restree<CR>", { buffer = true, silent = true })
  end,
})
