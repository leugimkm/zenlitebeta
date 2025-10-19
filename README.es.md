<p align="center">
  <img src="https://img.shields.io/badge/Neovim-%5E0.9.0-green?style=flat-square&logo=neovim" alt="Neovim version" />
  <img src="https://img.shields.io/github/license/leugimkm/zenlite.nvim?style=flat-square&color=lightgrey" alt="License" />
</p>

# 🪷 ZenLite

Un plugin liviano para Neovim que ofrece un modo zen minimalista.
A lightweight zen-mode plugin for Neovim.

ZenLite te ayuda a reducir el ruido visual ocultando elementos de la interfaz como la barra de estado, los números de línea, los diagnósticos y más — permitiéndote concentrarte únicamente en tu código.

---

## ✨ Características

- 🔕 Oculta **statusline**, **line numbers**, **diagnostics**, **sign column**, y **color column**.
- 🌗 Integración opcional con **Twilight.nvim** para atenuar el código inactivo.
- 🧠 Soporte para funciones personalizadas al **activar/desactivar** el modo Zen.
- 🧩 Totalmente configurable con opciones y combinaciones de teclas definidas por el usuario.

---

## 📦 Instalación

Usando [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "leugimkm/zenlite.nvim",
  config = function()
    require("zenlite").setup()
  end,
}

```

## ⚙️ Configuración

ZenLite funciona perfectamente sin configuración, pero puedes personalizar cada aspecto del plugin:

```lua
require("zenlite").setup({
  keymaps = {
    zen = "<leader>tz",          -- Alternar modo Zen
    all = "<leader>ta",          -- Alternar statusline + lineNr + diagnostics
    statusline = "<leader>tb",   -- Alternar barra de estaod
    linenr = "<leader>tn",       -- Alternar lineNr + colorcolumn + signcolumn
    diagnostics = "<leader>td",  -- Alternar diagnósticos
    virtuallines = "<leader>tl", -- Alternar líneas virtuales de LSP
    virtualtext = "<leader>tt",  -- Alternar texto virtual de LSP
  },
  options = {
    laststatus = { on = 3, off = 0 },
    number = { on = true, off = false },
    relativenumber = { on = true, off = false },
    colorcolumn = { on = "80", off = "" },
    signcolumn = { on = "yes", off = "yes:3" },
  },
  diagnostics = { enable = true },
  twilight = { enable = true }, -- Habilita integración con Twilight (si está instaldo)
  custom_on = function()
    -- Opcional: ejecutar lógica personalizada al entrar en modo Zen
  end,
  custom_off = function()
    -- Opcional: ejecutar lógica personalizada al salir del modo Zen
  end,
})
```

## 🚀 Uso

|        Atajo | Acción                                                      |
| -----------: | :---------------------------------------------------------- |
| `<leader>tz` | Alternar ZenLite mode                                       |
| `<leader>ta` | Alternar statusline + lineNr + diagnostics                  |
| `<leader>tb` | Alternar barra de estado                                    |
| `<leader>tn` | Alternar lineNr, relativenumber, colorcolumn and signcolumn |
| `<leader>td` | Alternar diagnósticos de LSP                                |
| `<leader>tl` | Alternar líneas virtuales                                   |
| `<leader>tt` | Alternar texto virtual                                      |

You can freely redifine these keymaps in your `setup()` configuration.

### 🧠 Hooks personalizados

Puedes definir funciones personalizadas que se ejecutarán al entrar o salir del modo Zen:

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

## 🧑‍💻 Contribuciones

¡Las contribuciones son siempre bienvenidas!
Si tienes sugerencias, errores o ideas, no dudes en abrir un issue o enviar un pull request.

## Credits

Inspirado por [folke/zen-mode](https://github.com/folke/zen-mode.nvim) y [folke/twilight](https://github.com/folke/twilight.nvim).
