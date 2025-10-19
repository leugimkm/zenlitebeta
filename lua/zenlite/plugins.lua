local M = {}

function M.has_twilight()
  local ok, _ = pcall(require, "twilight")
  return ok
end

function M.toggle_twilight(state)
  if not M.has_twilight() then
    return
  end
  vim.cmd(state and "TwilightEnable" or "TwilightDisable")
end

function M.toggle_diagnostics(state)
  vim.diagnostic.enable(state)
end

function M.toggle_virtual(kind)
  local cfg = vim.diagnostic.config()
  if kind == "lines" then
    vim.diagnostic.config({ virtual_lines = not cfg.virtual_lines })
  elseif kind == "text" then
    vim.diagnostic.config({ virtual_text = not cfg.virtual_text })
  end
end

return M
