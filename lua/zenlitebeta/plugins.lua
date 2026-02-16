local M = {}

function M.has_twilight()
	local ok, mod = pcall(require, "twilight")
	return ok, mod
end

function M.setup_twilight(opts)
	local ok, twilight = M.has_twilight()
	if not ok or not twilight or type(twilight.setup) ~= "function" then
		vim.notify("[ZenLite] Twilight not found or invalid setup().", vim.log.levels.WARN)
		return
	end

	if M._twilight_configured then
		return
	end

	local success, err = pcall(function()
		twilight.setup(opts or {})
	end)

	if not success then
		vim.notify("[ZenLite] Failed to setup Twilight: " .. err, vim.log.levels.ERROR)
	else
		M._twilight_configured = true
	end
end

function M.toggle_twilight(state)
	local ok = M.has_twilight()
	if not ok then
		return
	end
	vim.cmd(state and "TwilightEnable" or "TwilightDisable")
end

return M
