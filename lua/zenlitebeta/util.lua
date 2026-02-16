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

function M.toggle_diagnostics(state)
	vim.diagnostic.enable(state)
end

function M.toggle_diagnostics_auto()
	local is_enabled = vim.diagnostic.is_enabled()
	vim.diagnostic.enable(not is_enabled)
end

function M.toggle_virtual(kind)
	local cfg = vim.diagnostic.config() or {}
	if kind == "lines" then
		vim.diagnostic.config({ virtual_lines = not (cfg.virtual_lines or false) })
	elseif kind == "text" then
		vim.diagnostic.config({ virtual_text = not (cfg.virtual_text or false) })
	end
end

return M
