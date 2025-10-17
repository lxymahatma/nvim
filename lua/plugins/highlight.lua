return {
    -- Syntax Highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        lazy = false,
        build = ":TSUpdate",
        opts_extend = { "ensure_installed" },
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "bash",
                "diff",
                "query",
                "regex",
                "vim",
                "vimdoc",
            },
        },
        config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
    },

    -- Rainbow Brackets
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = "BufEdit",
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
        event = "BufEdit",
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
