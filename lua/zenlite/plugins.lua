local M = {}

function M.toggle_diagnostics(state)
  vim.diagnostic.enable(state)
end

function M.toggle_twilight(state)
  local ok, _ = pcall(require, "twilight")
  if not ok then
    return
  end
  if state then
    vim.cmd("TwilightEnable")
  else
    vim.cmd("TwilightDisable")
  end
end

function M.register_keymaps(opts, toggle_fn, toggle_option_fn, toggle_all_fn)
  local km = opts.keymaps
  vim.keymap.set("n", km.zen, toggle_fn, { desc = "Toggle zen mode" })
  vim.keymap.set("n", km.all, M.toggle_all, { desc = "Toggle all (statusline, lineNr, diagnostics)" })
  vim.keymap.set("n", km.statusline, function() toggle_option_fn("laststatus") end, { desc = "Toggle statusline" })
  vim.keymap.set("n", km.linenr, function() toggle_option_fn("number") end, { desc = "Toggle line numbers" })
  vim.keymap.set("n", km.diagnostics, function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end, { desc = "Toggle diagnostics" })
  vim.keymap.set("n", km.virtuallines, function()
    local state = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = state })
  end, { desc = "Toggle diagnostic virtual_lines" })
  vim.keymap.set("n", km.virtualtext, function()
    local state = not vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = state })
  end, { desc = "Toggle diagnostic virtual_text" })
end

return M
