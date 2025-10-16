local config = {}

config.colorscheme = "catppuccin"
config.enabled_langs = require("helpers.lang_loader").get_enabled_langs()

require("config.options")
require("config.lazy").setup(config.enabled_langs)
require("config.colorschemes").setup(config.colorscheme)
require("config.languages")
