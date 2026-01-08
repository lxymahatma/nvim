require("helpers.storage").init()

local colorscheme = "catppuccin"

-- leader key
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local toolchain = require("toolchain")
toolchain.setup()

require("config.options")
require("config.diagnostic")
require("config.autocmds")
require("config.bootstrap")
require("config.events").setup()
require("config.lazy").setup(toolchain.get_extra_plugins())
require("config.colorschemes").setup(colorscheme)
require("config.highlight")
require("config.pickers").setup()
require("config.keymaps")

require("toolchain.commands")
