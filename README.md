<p align="center">
  <img src="https://img.shields.io/badge/Neovim-%5E0.9.0-green?style=flat-square&logo=neovim" alt="Neovim version" />
  <img src="https://img.shields.io/github/license/leugimkm/zenlite.nvim?style=flat-square&color=lightgrey" alt="License" />
</p>

# 🪷 ZenLite

A lightweight zen-mode plugin for Neovim.

ZenLite helps you reduce visual noise by hiding UI elements such as the statusline, line numbers, diagnostics, and more — allowing you to focus purely on your code.

---

## ✨ Features

- 🔕 Hide **statusline**, **line numbers**, **diagnostics**, **sign column**, and **color column**.
- 🌗 Optional integration with **Twilight.nvim** for dimming inactive code.
- 🧠 Custom **on/off hooks** to execute your own logic when entering or leaving Zen mode.
- 🧩 Fully configurable with user-defined options and keymaps.

---

## 📦 Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{ "leugimkm/zenlite.nvim", opts = {} }
```

## ⚙️ Configuration

ZenLite works out of the box, but you can customize every aspect of it:

```lua
{
  "leugimkm/zenlite.nvim",
  -- default values
  opts = {
    keymaps = {
      zen = "<leader>tz",          -- Toggle Zen mode
      all = "<leader>ta",          -- Toggle all (statusline, lineNr, diagnostics)
      statusline = "<leader>tb",   -- Toggle statusline
      linenr = "<leader>tn",       -- Toggle lineNr, colorcolumn and signcolumn
      diagnostics = "<leader>td",  -- Toggle diagnostics
      virtuallines = "<leader>tl", -- Toggle LSP virtual lines
      virtualtext = "<leader>tt",  -- Toggle LSP virtual text
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
        opts =  {
            context = -1,
        }
    },
    custom_on = function()
      print("Entering Zen mode")
    end,
    custom_off = function()
      print("Leaving Zen mode")
    end,
  },
}
```


## 🚀 Usage

|       Keymap | Action                                                    |
| -----------: | :-------------------------------------------------------- |
| `<leader>tz` | Toggle ZenLite mode                                       |
| `<leader>ta` | Toggle statusline + lineNr + diagnostics                  |
| `<leader>tb` | Toggle statusline                                         |
| `<leader>tn` | Toggle lineNr, relativenumber, colorcolumn and signcolumn |
| `<leader>td` | Toggle LSP diagnostics                                    |
| `<leader>tl` | Toggle virtual lines                                      |
| `<leader>tt` | Toggle virtual text                                       |

You can freely redifine these keymaps in your `setup()` configuration.

### 🧠 Hooks

You can define custom functions that will be executed when ZenLite mode is toggled:

```lua
require("zenlite").setup({
  custom_on = function()
    print("Entering focus mode...")
  end,
  custom_off = function()
    print("Leaving focus mode...")
  end,
})
```

## 🧑‍💻 Contributing

Pull requests, bug reports, and feature suggestions are always welcome!
Feel free to open an issue or submit a PR.

## Credits

Inspired by [folke/zen-mode](https://github.com/folke/zen-mode.nvim) and [folke/twilight](https://github.com/folke/twilight.nvim).
