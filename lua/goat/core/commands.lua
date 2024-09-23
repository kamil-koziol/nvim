function IfErr()
  -- Get the cursor byte position
  local bpos = vim.fn.wordcount().cursor_bytes

  -- Run the external command with the position
  local out = vim.fn.systemlist("iferr -pos " .. bpos, vim.fn.bufnr("%"))

  -- If the output length is 1, exit the function
  if #out == 1 then
    return
  end

  -- Get the current cursor position
  local pos = vim.fn.getcurpos()

  -- Append the output to the current buffer
  vim.fn.append(pos[2], out)

  -- Move the cursor down, reindent and then move back
  vim.cmd("silent normal! j=2j")
  vim.fn.setpos(".", pos)
  vim.cmd("silent normal! 4j")
end

vim.api.nvim_create_user_command("IfErr", IfErr, {})
