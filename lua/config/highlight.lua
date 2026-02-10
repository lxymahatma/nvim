local colors = require("config.colors").catppuccin

-- Filetype picker highlights
Snacks.util.set_hl({
    Treesitter = { fg = colors.green },
    Lsp = { fg = colors.blue },
    Formatter = { fg = colors.peach },
    Linter = { fg = colors.red },
}, { prefix = "SnacksPickerFt", default = true })

-- Toolchain UI highlights
Snacks.util.set_hl({
    TabActive = { fg = colors.blue, bold = true },
    TabInactive = { fg = colors.overlay0 },
    Enabled = { fg = colors.green },
    Disabled = { fg = colors.overlay0 },
    Name = { fg = colors.text },
    TypeLang = { fg = colors.yellow },
    TypeTool = { fg = colors.sky },
    Default = { fg = colors.red },
    Footer = { fg = colors.overlay0, italic = true },
}, { prefix = "Toolchain" })

-- Blink Pairs highlights
Snacks.util.set_hl({
    Red = { fg = colors.red },
    Yellow = { fg = colors.yellow },
    Blue = { fg = colors.blue },
    Orange = { fg = colors.peach },
    Green = { fg = colors.green },
    Violet = { fg = colors.mauve },
    Cyan = { fg = colors.sky },
}, { prefix = "BlinkPairs", default = true })
