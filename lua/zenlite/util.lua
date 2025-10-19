local M = {}

function M.save_option(saved, name)
  saved[name] = vim.opt[name]:get()
end

function M.restore_option(saved, name)
  if saved[name] ~= nil then
    vim.opt[name] = saved[name]
  end
end

function M.apply_option(opts, name, state)
  local opt = opts[name]
  if opt then
    vim.opt[name] = opt[state and "on" or "off"]
  end
end

return M
