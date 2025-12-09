require("helpers.storage").init()

local colorscheme = "catppuccin"

-- leader key
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.diagnostic")
require("config.autocmds")
require("config.bootstrap")
require("config.events").setup()
require("config.lazy").setup()
require("config.colorschemes").setup(colorscheme)
require("config.keymaps")

require("langs.commands")
require("tools.commands")
