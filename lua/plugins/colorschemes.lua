return {
    -- tokyonight
    {
        "folke/tokyonight.nvim",
        lazy = true,

        ---@type tokyonight.Config
        opts = {},
    },

    -- catppuccin
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,

        ---@type CatppuccinOptions
        opts = {
            flavour = "mocha",
            integrations = {
                aerial = true,
                blink_cmp = {
                    style = "bordered",
                },
                copilot_vim = true,
                dap = true,
                dap_ui = true,
                dashboard = true,
                flash = true,
                gitsigns = {
                    enabled = true,
                    transparent = false,
                },
                grug_far = true,
                lsp_trouble = true,
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
                treesitter = true,
                treesitter_context = true,
                which_key = true,
            },
        },
    },
}
