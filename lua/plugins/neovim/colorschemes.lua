return {
    -- tokyonight
    {
        "folke/tokyonight.nvim",
        lazy = true,
        opts = {},
    },

    -- catppuccin
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
        opts = {
            integrations = {
                blink_cmp = true,
                dashboard = true,
                flash = true,
                fzf = true,
                gitsigns = true,
                grug_far = true,
                lsp_trouble = true,
                markdown = true,
                mason = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                        ok = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                        ok = { "underline" },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
                neotree = true,
                noice = true,
                notify = true,
                overseer = true,
                rainbow_delimiters = true,
                render_markdown = true,
                snacks = true,
                symbols_outline = true,
                treesitter = true,
                treesitter_context = true,
                which_key = true,
            },
        },
    },
}
