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
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "norg", "rmd", "org" },
        opts = {
            completions = { lsp = { enabled = true } },
            anti_conceal = {
                disabled_modes = { "n" },
            },
            latex = { enabled = false },
        },
    },
}
