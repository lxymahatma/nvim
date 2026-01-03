--- @type LanguageSpec
return {
    treesitter = {
        "markdown",
        "markdown_inline",
    },
    mason = {
        "marksman",
        "markdownlint-cli2",
    },
    lsp = "marksman",
    linter = "markdownlint-cli2",
    formatter = "markdownlint-cli2",
    plugin = {
        "OXY2DEV/markview.nvim",
        lazy = false,
        opts = function()
            local presets = require("markview.presets")

            --- @type markview.config
            return {
                markdown = {
                    enable = true,
                    headings = presets.headings.glow,
                    horizontal_rules = presets.horizontal_rules.thick,
                    tables = presets.tables.single,
                    code_blocks = {
                        pad_amount = 1,
                    },
                },
                markdown_inline = {
                    enable = true,
                    inline_codes = {
                        padding_left = "",
                        padding_right = "",
                    },
                },
                html = {
                    enable = true,
                },
                latex = {
                    enable = true,
                    blocks = {
                        pad_amount = 2,
                    },
                },
                typst = {
                    enable = true,
                    code_blocks = {
                        pad_amount = 2,
                    },
                },
                yaml = {
                    enable = true,
                },
                preview = {
                    enable = true,
                    enable_hybrid_mode = true,
                    icon_provider = "mini",
                },
            }
        end,
    },
}
