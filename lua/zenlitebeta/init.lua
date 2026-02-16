local config = require("lua.zenlitebeta.config")
local util = require("lua.zenlitebeta.util")
local plugins = require("lua.zenlitebeta.plugins")

local M = { _active = false, _saved = {}, opts = {} }

local function enter()
	for name in pairs(M.opts.options) do
		util.save_option(M._saved, name)
		util.apply_option(M.opts.options, name, false)
	end

	if M.opts.diagnostics.enable then
		util.toggle_diagnostics(false)
	end

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

	if M.opts.diagnostics.enable then
		util.toggle_diagnostics(true)
	end

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
		util.apply_option(M.opts.options, "signcolumn", new_state)
	end
end

function M.toggle_all()
	local status_on = vim.opt.laststatus:get() == M.opts.options.laststatus.on
	local new_state = not status_on

	util.apply_option(M.opts.options, "laststatus", new_state)
	M.toggle_option("number")

	local diag_state = vim.diagnostic.is_enabled()
	vim.diagnostic.enable(not diag_state)
end

function M.setup(user_opts)
	M.opts = config.load(user_opts)

	if M.opts.twilight.enable and next(M.opts.twilight.opts) ~= nil then
		plugins.setup_twilight(M.opts.twilight.opts)
	end

	local km = M.opts.keymaps
	vim.keymap.set("n", km.zen, M.toggle, { desc = "Toggle zen mode" })
	vim.keymap.set("n", km.all, M.toggle_all, { desc = "Toggle all (statusline, lineNr, diagnostics)" })
	vim.keymap.set("n", km.statusline, function()
		M.toggle_option("laststatus")
	end, { desc = "Toggle statusline" })
	vim.keymap.set("n", km.linenr, function()
		M.toggle_option("number")
	end, { desc = "Toggle line numbers" })
	vim.keymap.set("n", km.diagnostics, function()
		util.toggle_diagnostics_auto()
	end, { desc = "Toggle diagnostics" })
	vim.keymap.set("n", km.virtuallines, function()
		util.toggle_virtual("lines")
	end, { desc = "Toggle diagnostic virtual_lines" })
	vim.keymap.set("n", km.virtualtext, function()
		util.toggle_virtual("text")
	end, { desc = "Toggle diagnostic virtual_text" })

	vim.api.nvim_create_user_command("ZenModeToggle", function()
		M.toggle()
	end, {})
end

return setmetatable(M, {
	__call = function(_, opts)
		M.setup(opts)
	end,
})
