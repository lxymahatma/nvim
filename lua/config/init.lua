require("helpers.storage").init()

local colorscheme = "catppuccin"

-- leader key
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local parsers = require("config.parsers")
parsers.setup()

require("config.options")
require("config.diagnostic")
require("config.autocmds")
require("config.bootstrap")
require("config.events").setup()
require("config.lazy").setup(parsers.get_extra_plugins())
require("config.colorschemes").setup(colorscheme)
require("config.keymaps")

require("langs.commands")
require("tools.commands")
