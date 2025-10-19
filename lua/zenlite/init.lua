local config = require("zenlite.config")
local util = require("zenlite.util")
local plugins = require("zenlite.plugins")

local M = { _active = false, _saved = {}, opts = {} }

local function enter()
	for name in pairs(M.opts.options) do
		util.save_option(M._saved, name)
		util.apply_option(M.opts.options, name, false)
	end

	plugins.toggle_diagnostics(false)
	if M.opts.twilight.enable then
		plugins.toggle_twilight(true)
	end

	if type(M.opts.custom_on) == "function" then
		M.opts.custom_on()
	end
end

local function exit()
	for name in pairs(M.opts.options) do
		util.restore_option(M._saved, name)
	end

	plugins.toggle_diagnostics(true)
	if M.opts.twilight.enable then
		plugins.toggle_twilight(false)
	end

	if type(M.opts.custom_off) == "function" then
		M.opts.custom_off()
	end
end

function M.toggle()
	M._active = not M._active
	if M._active then
		enter()
	else
		exit()
	end
end

function M.toggle_option(name)
	if not M.opts.options[name] then
		return
	end

	local current = vim.opt[name]:get()
	local is_on = current == M.opts.options[name].on
	local new_state = not is_on

	util.apply_option(M.opts.options, name, new_state)

	if name == "number" then
		util.apply_option(M.opts.options, "relativenumber", new_state)
		util.apply_option(M.opts.options, "colorcolumn", new_state)
		local sc = M.opts.options.signcolumn
		if sc then
			vim.opt.signcolumn = new_state and sc.on or sc.off
		end
	end
end

function M.toggle_all()
	local status_active = vim.opt.laststatus:get() == M.opts.options.laststatus.on
	local linenr_active = vim.opt.number:get()
	local diagnostics_active = vim.diagnostic.is_enabled()

	local new_state = not (status_active and linenr_active and diagnostics_active)

	util.apply_option(M.opts.options, "laststatus", new_state)
	M.toggle_option("number")
	plugins.toggle_diagnostics(new_state)
end

function M.setup(user_opts)
	M.opts = config.load(user_opts)
	plugins.register_keymaps(M.opts, M.toggle, M.toggle_option)
end

return M
