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
        event = "BufEdit",
        ft = { "markdown", "norg", "rmd", "org" },

        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            completions = { lsp = { enabled = true } },
        },
    },
}
