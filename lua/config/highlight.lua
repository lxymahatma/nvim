local colors = require("config.colors")

Snacks.util.set_hl({
    Treesitter = { fg = colors.green },
    Lsp = { fg = colors.blue },
    Formatter = { fg = colors.peach },
    Linter = { fg = colors.red },
}, { prefix = "SnacksPickerFt", default = true })
