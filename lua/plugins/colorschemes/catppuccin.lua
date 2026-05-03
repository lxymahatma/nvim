-- catppuccin
---@type LazyPluginSpec
return {
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
            blink_pairs = true,
            dap = true,
            dap_ui = true,
            flash = true,
            grug_far = true,
            lsp_trouble = true,
            markview = true,
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
            overseer = true,
            snacks = {
                enabled = true,
            },
            treesitter = true,
            treesitter_context = true,
            which_key = true,
        },
    },
}
