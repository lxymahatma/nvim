return {
    -- Syntax Highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        event = "VeryLazy",
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "diff",
                "json",
                "markdown",
                "markdown_inline",
                "query",
                "regex",
                "toml",
                "xml",
                "yaml",
            },
        },
    },

    -- Markdown Syntax Highlighting
    {
        "MeanderingProgrammer/render-markdown.nvim",
        event = "VeryLazy",
        ft = { "markdown", "norg", "rmd", "org" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "echasnovski/mini.icons",
        },
        opts = {},
    },

    -- Rainbow Brackets
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = "VeryLazy",
        main = "rainbow-delimiters.setup",
        opts = function()
            local rb = require("rainbow-delimiters")
            return {
                strategy = {
                    [""] = rb.strategy["global"],
                    vim = rb.strategy["local"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                },
                priority = {
                    [""] = 110,
                    lua = 210,
                },
                highlight = {
                    "RainbowDelimiterRed",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                },
            }
        end,
    },

    -- Highlight colors
    {
        "brenoprata10/nvim-highlight-colors",
        event = "VeryLazy",
        opts = {
            render = "background",

            ---Highlight hex colors, e.g. "#FFFFFF"
            enable_hex = true,

            ---Highlight short hex colors e.g. '#fff'
            enable_short_hex = true,

            ---Highlight rgb colors, e.g. 'rgb(0 0 0)'
            enable_rgb = true,

            ---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
            enable_hsl = true,

            ---Highlight CSS variables, e.g. 'var(--testing-color)'
            enable_var_usage = true,

            ---Highlight named colors, e.g. 'green'
            enable_named_colors = true,

            ---Highlight tailwind colors, e.g. 'bg-blue-500'
            enable_tailwind = true,
        },
    },
}
