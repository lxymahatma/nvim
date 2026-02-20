--- @type LanguageSpec
return {
    treesitter = true,
    mason = {
        "yamlls",
        "yamllint",
        "yamlfmt",
    },
    lsp = "yamlls",
    linter = "yamllint",
    formatter = "yamlfmt",
    formatter_opts = {
        yamlfmt = {
            prepend_args = { "-formatter", "indent=2,retain_line_breaks_single=true" },
        },
    },
}
