local config = {}

config.colorscheme = "catppuccin"

local default_langs = {
    "git",
    "json",
    "lua",
    "markdown",
    "nushell",
    "toml",
    "xml",
    "yaml",
}

local extra_langs = require("helpers.lang_loader").get_extra_langs()
config.enabled_langs = vim.list_extend(default_langs, extra_langs)

require("config.options")
require("config.lazy").setup(config.enabled_langs)
require("config.colorschemes").setup(config.colorscheme)
