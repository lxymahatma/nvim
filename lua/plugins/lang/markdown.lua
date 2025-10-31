return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "markdown",
                "markdown_inline",
            },
        },
    },

    -- Markdown Syntax Highlighting
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "norg", "rmd", "org" },

        ---@type render.md.UserConfig
        opts = {
            completions = { lsp = { enabled = true } },
            anti_conceal = {
                disabled_modes = { "n" },
            },
            latex = { enabled = false },
        },
    },
}
