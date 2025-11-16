local config = {}

config.colorscheme = "catppuccin"
config.enabled_langs = require("helpers.lang-loader").get_enabled_langs()

-- leader key
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.diagnostic")
require("config.autocmds")
require("config.bootstrap")
require("config.events").setup()
require("config.lazy").setup(config.enabled_langs)
require("config.colorschemes").setup(config.colorscheme)
require("config.languages")
require("config.keymaps")
