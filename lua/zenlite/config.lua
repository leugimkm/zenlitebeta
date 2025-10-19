local M = {}

M.defaults = {
  keymaps = {
    zen = "<leader>tz",
    all = "<leader>ta",
    statusline = "<leader>tb",
    linenr = "<leader>tn",
    diagnostics = "<leader>td",
    virtuallines = "<leader>tl",
    virtualtext = "<leader>tt",
  },
  options = {
    laststatus = { on = 3, off = 0 },
    number = { on = true, off = false },
    relativenumber = { on = true, off = false },
    colorcolumn = { on = "80", off = "" },
    signcolumn = { on = "yes", off = "yes:3" },
  },
  diagnostics = { enable = true },
  twilight = {
    enable = true,
    opts = {
      context = -1,
    },
  },
  custom_on = nil,
  custom_off = nil,
}

function M.load(user_opts)
  return vim.tbl_deep_extend("force", M.defaults, user_opts or {})
end

return M
