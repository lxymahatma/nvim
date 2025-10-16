local config = {}

config.colorscheme = "catppuccin"
config.enabled_langs = require("helpers.lang_loader").get_enabled_languages()

require("config.lazy").setup(config.enabled_langs)
require("config.options")
require("config.colorschemes").setup(config.colorscheme)
