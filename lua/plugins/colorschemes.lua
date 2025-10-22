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
            flavour = "mocha",
            integrations = {
                blink_cmp = {
                    style = "bordered",
                },
                copilot_vim = true,
                dashboard = true,
                flash = true,
                gitsigns = {
                    enabled = true,
                    transparent = false,
                },
                grug_far = true,
                mason = true,
                mini = {
                    enabled = true,
                },
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
                noice = true,
                notify = true,
                overseer = true,
                rainbow_delimiters = true,
                render_markdown = true,
                snacks = {
                    enabled = true,
                },
                symbols_outline = true,
                treesitter = true,
                treesitter_context = true,
                lsp_trouble = true,
                which_key = true,
            },
        },
    },
}
