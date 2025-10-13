local config = {}

require("config.lazy")

config.colorscheme = "catppuccin"
require("config.options")
require("config.colorschemes").setup(config.colorscheme)
